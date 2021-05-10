from imutils import face_utils
import dlib
import cv2
 
# Vamos inicializar um detector de faces (HOG) para então
# let's go code an faces detector(HOG) and after detect the 
# landmarks on this detected face

# p = our pre-treined model directory, on my case, it's on the same script's diretory.
p = "shape_predictor_68_face_landmarks.dat"
detector = dlib.get_frontal_face_detector()
predictor = dlib.shape_predictor(p)

cap = cv2.VideoCapture(1)
distance=0
eye=[0,0]
while True:
    eye=[0,0]
    # Getting out image by webcam 
    _, image = cap.read()
    # Converting the image to gray scale
    gray = cv2.cvtColor(image, cv2.COLOR_BGR2GRAY)
        
    # Get faces into webcam's image
    rects = detector(gray, 0)
    # For each detected face, find the landmark.
    for (i, rect) in enumerate(rects):
        # Make the prediction and transfom it to numpy array
        shape = predictor(gray, rect)
        shape = face_utils.shape_to_np(shape)
        # Draw on our image, all the finded cordinate points (x,y) 
        # for (x, y) in shape:
        #     cv2.circle(image, (x, y), 2, (0, 255, 0), -1)
    for x in range(len (shape)):
        # Pick the dots in the eyes
        if(x>=36 and x<=47):
            eye[0]+=shape[x][0]
            eye[1]+=shape[x][1]
            cv2.circle(image, shape[x], 2, (255, 0, 0), -1)
        else:
            cv2.circle(image, shape[x], 2, (0, 255, 0), -1)

    # calculate midEyePosition
    eye[0]=int(eye[0]/12)
    eye[1]=int(eye[1]/12)

    cv2.circle(image, eye, 2, (0, 0, 255), -1)

    # calculate distance from top right face minus left right face
    distance=shape[15][0]-shape[1][0]
    
    # Show the image
    cv2.imshow("Output", image)
    
    # wait for escape
    k = cv2.waitKey(5) & 0xFF
    if k == 27:
        break

    # Fix kruisje
    if cv2.getWindowProperty("Output", 0) < 0:
        break

cv2.destroyAllWindows()
cap.release()