import numpy as np
import threading
import cv2
import socket
import time
import sys
from PIL import Image

from utils import draw_bounding_box, load_model, detect_clothes, get_clothing_cropped, get_dominant_color, is_torso_piece, quantize_to_palette

model = load_model()

clothing_types = ['short_sleeve_top', 'long_sleeve_top', 'short_sleeve_outwear', 'long_sleeve_outwear',
                  'vest', 'sling', 'shorts', 'trousers', 'skirt', 'short_sleeve_dress',
                  'long_sleeve_dress', 'vest_dress', 'sling_dress']

capture = cv2.VideoCapture(0)
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
bias_torso_piece = True
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
        global detected_type, detected_color, multiple_detected, bias_torso_piece, hits
        cloth = None
        if len(detected_objects) > 1:
            registered_cloth = None
            for i in range(0, 2):
                if((is_torso_piece(detected_objects[i]['label']) is bias_torso_piece) and (registered_cloth is None)):
                    registered_cloth = detected_objects[i]
            if registered_cloth is None:
                registered_cloth = detected_objects[0]
                bias_torso_piece = not bias_torso_piece
            cloth = registered_cloth
        else:
            cloth = detected_objects[0]
        if not cloth['label'] == detected_type:
            hits = 0
            detected_type = cloth['label']
        else:
            hits += 1
        clothing_image = get_clothing_cropped(crop_img, cloth)
        conv_image = cv2.cvtColor(clothing_image, cv2.COLOR_BGR2RGB)
        pil_image = Image.fromarray(conv_image)
        paletted_image = quantize_to_palette(pil_image).convert('RGB')
        cv_paletted_image = np.array(paletted_image)
        clothing_final_image = cv2.cvtColor(cv_paletted_image, cv2.COLOR_BGR2RGB)
        cv2.imshow('paletted', clothing_final_image)
        color = get_dominant_color(clothing_final_image)
        detected_color = color
        image_bounding_box = draw_bounding_box(crop_img, cloth, color)
        cv2.imshow('clothes', image_bounding_box)
    else:
        hits = 0
        detected_type = None
        detected_color = None
        bias_torso_piece = not bias_torso_piece

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