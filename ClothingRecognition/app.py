import numpy as np
import threading
import cv2
import socket
import time
import sys

from utils import draw_bounding_box, load_model, detect_clothes, get_clothing_cropped, get_dominant_color

model = load_model()

clothing_types = ['short_sleeve_top', 'long_sleeve_top', 'short_sleeve_outwear', 'long_sleeve_outwear',
                  'vest', 'sling', 'shorts', 'trousers', 'skirt', 'short_sleeve_dress',
                  'long_sleeve_dress', 'vest_dress', 'sling_dress']

capture = cv2.VideoCapture(2)
readCorrectly, frame = capture.read()
cv2.imshow('preview', frame)

frameRate = 30
detectionRate = 1
frames = 0
imageBox = (84, 0, 500, 480)
hits = 0

# TCP server settings
TCP_IP = 'localhost'
TCP_PORT = 6969
TCP_TICKRATE = 30

detected_type = None
detected_color = None

def server_handling():
    # While loop to keep tring to re-establish a connection
    while(True):
        # Wait for incoming client
        client, ip = server.accept()
        print("Client connected")
        while(True):
            try:
                # Construct the payload and send it. Wait a tick length before sending the next packet
                payload = "Oopsie whoopsie whoops whoops whoops herres in de tent alles ging fout\n"
                if detected_color is not None:
                    payload = f"{detected_type},{detected_color[2]},{detected_color[1]},{detected_color[0]},{hits}\n"
                else:
                    payload = f"{detected_type},bruh,bruh,bruh,{hits}\n"
                client.send(payload.encode())
                time.sleep(1 / TCP_TICKRATE)
            except Exception as e:
                # Presumably the payload failed to send, so the client has lost connection
                print("Client disconnected")
                print(e)
                break
        # Close connection with the client upon disconnect
        client.close()

# Set up TCP server
server = socket.socket(socket.AF_INET, socket.SOCK_STREAM)
server.bind((TCP_IP, TCP_PORT))
server.listen()
server_thread = threading.Thread(target=server_handling)
server_thread.setDaemon(True)
server_thread.start()

def detect(image):
    crop_img = image[imageBox[1]:imageBox[1] + imageBox[3], imageBox[0]:imageBox[0] + imageBox[2]]
    detected_objects = detect_clothes(crop_img, model, clothing_types)
    if len(detected_objects) > 0:
        global detected_type, detected_color, hits
        clothing_image = get_clothing_cropped(crop_img, detected_objects[0])
        color = get_dominant_color(clothing_image)
        type = detected_objects[0]['label']
        if not type == detected_type:
            hits = 0
            detected_type = type
        else:
            hits += 1
        detected_color = color
        image_bounding_box = draw_bounding_box(crop_img, detected_objects[0], color)
        cv2.imshow('clothes', image_bounding_box)
    else:
        hits = 0
        detected_type = None
        detected_color = None

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
server.close()
sys.exit()  # This will also kill the server thread