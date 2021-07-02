"""
Clothing detection utilities

Original author: Shen Wei-Hsiang
Altered by: Frank Bosman & Max Liebe
"""

import numpy as np
import tensorflow as tf
import cv2
from PIL import Image

from yolov3_tf2.models import YoloV3

def draw_bounding_box(image, cloth, color):
    width = image.shape[1]
    height = image.shape[0]

    color_box = [int(color[0]), int(color[1]), int(color[2])]

    x1 = int(round(cloth['x1'] * width))
    y1 = int(round(cloth['y1'] * height))
    x2 = int(round(cloth['x2'] * width))
    y2 = int(round(cloth['y2'] * height))

    text = f"{cloth['label']}: {cloth['confidence']:.2f}"

    image = cv2.rectangle(image, (x1, y1), (x2, y2), color_box, 4)
    image = cv2.putText(image, text, (x1, y1-5), cv2.FONT_HERSHEY_SIMPLEX, 1, color_box, 2, cv2.LINE_AA) #note fix dit
    return image

def load_model():
    model = YoloV3(classes=13)
    model.load_weights('./built_model/deepfashion2_yolov3')
    return model

def detect_clothes(image, model, clothing_types): 
    image_resized = cv2.resize(image, (416,416))
    image_rgb = cv2.cvtColor(image_resized, cv2.COLOR_BGR2RGB)
    image_divided = image_rgb / 255
    image_tensor = tf.convert_to_tensor(image_divided, dtype=tf.float32)
    image_final = tf.expand_dims(image_tensor, 0)

    boxes, scores, classes, nums = model(image_final)
    boxes, scores, classes, nums = boxes.numpy(), scores.numpy(), classes.numpy(), nums.numpy()

    detected_objects = []
    for i in range(nums[0]):
        obj = {
            'label':clothing_types[int(classes[0][i])],
            'confidence':scores[0][i],
            'x1' : boxes[0][i][0],
            'y1' : boxes[0][i][1],
            'x2' : boxes[0][i][2],
            'y2' : boxes[0][i][3]
        }
        detected_objects.append(obj)
    return detected_objects

def get_clothing_cropped(image, cloth):
    width = image.shape[1]
    height = image.shape[0]
    margin = 40
    max_width = 250

    # crop out one cloth
    x1 = margin + int(cloth['x1'] * width)
    x2 = -margin + int(cloth['x2'] * width)
    if x2 - x1 > max_width:
        overshot = x2 - x1 - max_width
        x1 += int(overshot / 2)
        x2 -= int(overshot / 2)
    y1 = margin + int(cloth['y1'] * height)
    y2 = -margin + int(cloth['y2'] * height)
    cropped = image[y1:y2, x1:x2]
    return cropped

def get_dominant_color(img):
    colors, count = np.unique(img.reshape(-1, img.shape[-1]), axis=0, return_counts=True)
    if count.any():
        return colors[count.argmax()]
    return (255, 255, 255)

def is_torso_piece(cloth):
    torso_pieces = ['short_sleeve_top', 'long_sleeve_top', 'short_sleeve_outwear', 'long_sleeve_outwear',
                  'vest', 'sling']
    for i in range(0, len(torso_pieces)):
        if cloth is torso_pieces[i]:
            return True
    return False

def quantize_to_palette(image, dither=False):
    image.load()
    palette_data = [
    # 50, 50, 50,    # black
    # 110, 110, 110, # dark gray
    # 170, 170, 170, # light gray
    # 255, 255, 255, # white

    160, 160, 160,
    0, 0, 0,
    0, 0, 0,
    0, 0, 0,

    255, 0, 0,     # red
    166, 66, 46,   # red
    171, 101, 87,  # red
    103, 34, 37,   # red

    186, 20, 81,   # red
    140, 6, 48,    # red
    166, 28, 56,   # red
    122, 5, 21,    # red

    156, 34, 40,   # red
    148, 18, 18,   # red
    255, 135, 10,  # orange
    150, 37, 0,    # orange

    186, 46, 0,    # orange
    207, 83, 0,    # orange
    196, 95, 0,    # orange
    145, 75, 5,    # brown

    97, 36, 16,    # brown
    128, 41, 13,   # brown
    255, 220, 0,   # yellow
    171, 153, 38,  # yellow

    112, 103, 42,  # yellow
    161, 155, 0,   # yellow
    194, 161, 43,  # yellow
    20, 220, 20,   # green

    164, 181, 33,  # green
    127, 143, 3,   # green
    118, 163, 3,   # green
    63, 105, 0,    # green

    64, 130, 26,   # green
    9, 117, 56,    # green
    0, 255, 210,   # turqouise
    9, 117, 81,    # turqouise

    31, 153, 129,  # turqouise
    5, 102, 83,    # turqouise
    35, 173, 171,  # turqouise
    11, 122, 121,  # turqouise

    5, 110, 255,   # blue
    20, 94, 112,   # blue
    0, 123, 153,   # blue
    32, 88, 128,   # blue

    2, 71, 120,    # blue
    40, 86, 184,   # blue
    33, 37, 163,   # blue
    160, 0, 255,   # purple

    50, 30, 130,   # purple
    32, 8, 92,     # purple
    81, 29, 140,   # purple
    95, 15, 186,   # purple

    82, 13, 120,   # purple
    158, 31, 204,  # purple
    255, 0, 210,   # pink
    191, 49, 204,  # pink

    148, 10, 143,  # pink
    179, 48, 174,  # pink
    128, 18, 104,  # pink
    212, 51, 177,  # pink

    163, 21, 106,  # pink
    80, 80, 80,    # dark gray
    140, 140, 140, # light gray
    190, 190, 190  # white
    ] * 4

    palette_image = Image.new('P', (16, 16)) #256 coloroiios
    palette_image.putpalette(palette_data)
    im = image.im.convert("P", 0, palette_image.im)
    return image._new(im)