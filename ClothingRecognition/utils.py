"""
Clothing detection utilities

Original author: Shen Wei-Hsiang
Altered by: Frank Bosman & Max Liebe
"""

import numpy as np
import tensorflow as tf
import cv2

from yolov3_tf2.models import YoloV3

def draw_bounding_box(image, detected_objects):
    width = image.shape[1]
    height = image.shape[0]

    color_green = [66, 241, 66]

    for obj in detected_objects:
        x1 = int(round(obj['x1'] * width))
        y1 = int(round(obj['y1'] * height))
        x2 = int(round(obj['x2'] * width))
        y2 = int(round(obj['y2'] * height))

        text = f"{obj['label']}: {obj['confidence']:.2f}"

        image = cv2.rectangle(image, (x1, y1), (x2, y2), color_green, 4)
        image = cv2.putText(image, text, (x1, y1-5), cv2.FONT_HERSHEY_SIMPLEX, 1, color_green, 2, cv2.LINE_AA) #note fix dit
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