//3d cam library
import peasy.*;
PeasyCam camera;
//kinect library
import KinectPV2.KJoint;
import KinectPV2.*;
KinectPV2 kinect;
//serial library for arduino communication
import processing.serial.*;
Serial port;
//TCP communication with eyes
import processing.net.*;
Server s;

//sketch in CM, -y is up
//als we 360 graden kunnen draaien 0 graden = recht vanuit kinect
//als 180 graden draaien opnieuw implementeren naar midden kijkend

boolean draw= true;
boolean useArduino=false;
PVector camPos=new PVector(0, -140, 0);
PVector screenPos=new PVector(0, -180, 0);
//the eye that is in the place of the middle of the screen to calc that lookingvector
Eye screen=new Eye(screenPos, -1);

JSONArray eyePosData;
ArrayList<Eye> eyes = new ArrayList<Eye>();
ArrayList<PVector> heads = new ArrayList<PVector>();
void setup() {
  //make an eye for every json eye
  eyePosData = loadJSONArray("../EyePos.JSON");
  for (int i = 0; i < eyePosData.size(); i++) {
    JSONObject eye = eyePosData.getJSONObject(i);
    eyes.add(new Eye(new PVector(eye.getFloat("x"), eye.getFloat("y"), eye.getFloat("z")), eye.getInt("id")));
  }

  size(1000, 1000, P3D);
  //fullScreen(P3D, 1);

  //make a new cam element
  camera = new PeasyCam(this, -2, 0, -1, 100);

  //init the kinect
  kinect = new KinectPV2(this);

  // Enable 3d  with (x,y,z) position
  kinect.enableSkeleton3DMap(true);

  kinect.init();

  //setup the TCP server
  s = new Server(this, 10001);
  //if you wanna draw the 3d space setup lights etc
  if (draw) {
    ambientLight(255, 255, 255);
    perspective(PI/3.0, width/height, 1, 10000);
    sphereDetail(1);
    rectMode(CENTER);
  }
  //print the available serial (arduino ports)
  if (useArduino) {
    println("Available serial ports:");
    for (int i = 0; i<Serial.list().length; i++) { 
      print("[" + i + "] ");
      println(Serial.list()[i]);
    }
    //init the port
    port = new Serial(this, Serial.list()[2], 9600);
  }
}

void draw() {
  //if you wanna display: make the ground and lights and draw the green kinect dot
  if (draw) {
    ambientLight(255, 255, 255);
    background(255);
    drawPoint(camPos, color (0, 255, 0));

    pushMatrix();  

    rotateX(PI/2);
    translate(0, 0, 0);
    rect(0, 0, 10000, 10000);
    popMatrix();
  }
  // Get the 3D data points from the 3D skeleton (access to Z point)
  ArrayList<KSkeleton> skeleton3DArray =  kinect.getSkeleton3d();

  //Make an arraylist for all the heads tracked this frame
  heads = new ArrayList<PVector>();

  for (int i = 0; i < skeleton3DArray.size(); i++) {
    KSkeleton skeleton3D = (KSkeleton) skeleton3DArray.get(i);
    if (skeleton3D.isTracked()) {
      KJoint[] joints3D = skeleton3D.getJoints();
      PVector[] myJoints= new PVector[joints3D.length];
      //add every joint to the arraylist to draw and every head to the heads arraylist
      for (int j=0; j<joints3D.length; j++) {
        PVector jointPos=new PVector(joints3D[j].getX()*100, -joints3D[j].getY()*100, joints3D[j].getZ()*100);
        myJoints[j]=camPos.copy().add(jointPos.copy());
        if (draw) {
          //not the kinect itself
          if (j!=25) {
            drawPoint(myJoints[j], color(255, 0, 0));
            fill(255, 0, 0);
          }
        }
        //if the point is the head add it to the arraylist
        if (j==3) {
          heads.add(myJoints[j]);
        }
      }

      //draw all the bones in the body
      if (draw) {
        drawBody(myJoints);
      }
    }
  }

  //show the framerate counter and ScreenEye
  if (draw) {
    fill(255, 0, 0);
    textSize(10);
    text(frameRate, 50, -50);
  }
  //update all the eyes, show if appropriate and send the data to the arduino
  String arduinoPayload="";
  for (Eye eye : eyes) {
    eye.update();
    if (draw) {
      eye.show();
    }
    arduinoPayload+=eye.id+","+eye.angleY+","+eye.angleZ+"|";
  }
  arduinoPayload+="\n";
  if (useArduino) {
    port.write(arduinoPayload);
  }

  //Adjust the lookingPos for the screen by the difference between kinect and screenmid
  //update the lookingvector of the screen
  screen.update();
  if (draw) {
    screen.show();
  }
  //send the lookingvector over TCP to the eyeSketch
  PVector adjustedLookingPos=PVector.sub(screen.closestHead, screen.pos);
  String TCPpayload=""+adjustedLookingPos.x+","+adjustedLookingPos.y+","+adjustedLookingPos.z+"\n";
  //(x,y,z,'\n')
  //write the coords to the drawing sketch
  s.write(TCPpayload);
}

//draw a point with on position pos
void drawPoint(PVector pos, color c) {
  pushMatrix();
  translate(pos.x, pos.y, pos.z);
  fill(c);
  sphere(2);
  popMatrix();
}

//draw a 3d line on the given pos and color
void draw3DLine(PVector pos1, PVector pos2, color c) {
  strokeWeight(3);
  stroke(c);
  line(pos1.x, pos1.y, pos1.z, pos2.x, pos2.y, pos2.z);
  stroke(0);
  strokeWeight(1);
}

//draw all the bones between the joints
void drawBody(PVector[] myJoints) {
  color blue=color(0, 0, 255);
  //leftLeg
  draw3DLine(myJoints[15], myJoints[14], blue);
  draw3DLine(myJoints[14], myJoints[13], blue);
  draw3DLine(myJoints[13], myJoints[12], blue);
  draw3DLine(myJoints[12], myJoints[0], blue);

  //rightLeg
  draw3DLine(myJoints[19], myJoints[18], blue);
  draw3DLine(myJoints[18], myJoints[17], blue);
  draw3DLine(myJoints[17], myJoints[16], blue);
  draw3DLine(myJoints[16], myJoints[0], blue);

  //leftArm
  draw3DLine(myJoints[21], myJoints[7], blue);
  draw3DLine(myJoints[7], myJoints[6], blue);
  draw3DLine(myJoints[6], myJoints[5], blue);
  draw3DLine(myJoints[5], myJoints[4], blue);
  draw3DLine(myJoints[4], myJoints[20], blue);
  //leftThumb
  draw3DLine(myJoints[22], myJoints[6], blue);

  //rightArm
  draw3DLine(myJoints[23], myJoints[11], blue);
  draw3DLine(myJoints[11], myJoints[10], blue);
  draw3DLine(myJoints[10], myJoints[9], blue);
  draw3DLine(myJoints[9], myJoints[8], blue);
  draw3DLine(myJoints[8], myJoints[20], blue);
  //rightThumb
  draw3DLine(myJoints[24], myJoints[10], blue);

  //spine
  draw3DLine(myJoints[0], myJoints[1], blue);
  draw3DLine(myJoints[1], myJoints[20], blue);
  draw3DLine(myJoints[20], myJoints[2], blue);
  draw3DLine(myJoints[2], myJoints[3], blue);
}
