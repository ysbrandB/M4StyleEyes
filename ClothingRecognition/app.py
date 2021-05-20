import numpy as np
import threading
import cv2

from utils import draw_bounding_box, load_model, detect_clothes

model = load_model()

clothing_types = ['short_sleeve_top', 'long_sleeve_top', 'short_sleeve_outwear', 'long_sleeve_outwear',
                  'vest', 'sling', 'shorts', 'trousers', 'skirt', 'short_sleeve_dress',
                  'long_sleeve_dress', 'vest_dress', 'sling_dress']

capture = cv2.VideoCapture(1)
readCorrectly, frame = capture.read()
cv2.imshow('preview', frame)

frameRate = 30
detectionRate = 1
frames = 0
imageBox = (84, 0, 500, 480)

def detect(image):
    crop_img = image[imageBox[1]:imageBox[1] + imageBox[3], imageBox[0]:imageBox[0] + imageBox[2]]
    detected_objects = detect_clothes(crop_img, model, clothing_types)
    image_bounding_box = draw_bounding_box(crop_img, detected_objects)
    cv2.imshow('clothes', image_bounding_box)

while cv2.getWindowProperty('preview', 0) >= 0:
    readCorrectly, frame = capture.read()
    cv2.imshow('preview', frame)
    key = cv2.waitKey((int)(1000 / frameRate))
    
    if key == 27: #escape
        break
    if frames % detectionRate == 0:
        detect(frame)
    frames += 1
cv2.destroyAllWindows()
