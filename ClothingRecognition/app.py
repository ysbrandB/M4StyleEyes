import numpy as np
import cv2

#remove if you want to use cuda
import os
os.environ["CUDA_VISIBLE_DEVICES"] = "-1"

from utils import draw_bounding_box, load_model, detect_clothes

clothing_types = ['short_sleeve_top', 'long_sleeve_top', 'short_sleeve_outwear', 'long_sleeve_outwear',
                  'vest', 'sling', 'shorts', 'trousers', 'skirt', 'short_sleeve_dress',
                  'long_sleeve_dress', 'vest_dress', 'sling_dress']

image = cv2.imread('sterre.png')
model = load_model()

detected_objects = detect_clothes(image, model, clothing_types)
image_bounding_box = draw_bounding_box(image, detected_objects)

cv2.imshow("HENKIE", image_bounding_box)
cv2.waitKey(0)