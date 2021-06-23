"""
Clothing detection utilities

Original author: Shen Wei-Hsiang
Altered by: Frank Bosman & Max Liebe
"""

import numpy as np
import tensorflow as tf
import cv2

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
    max_width = 200

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