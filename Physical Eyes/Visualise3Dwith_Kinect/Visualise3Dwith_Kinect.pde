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
String inString;

//TCP communication with eyes
import processing.net.*;
Server s;
Server sInterface;

//sketch in CM, -y is up
//Ogen bij startup kijken rechtdoor, rotatie is met de x as van de oogassembly door de kinect heen

boolean draw= true;
boolean useArduino=true;
boolean debug=true;
JSONObject setUpData;
PVector kinectPos;
PVector screenPos;
PVector crossPos;
float minimumDistToCross;
//the eye that is in the place of the middle of the screen to calc that lookingvector
Eye screen;
float time;

//to only send an update to interface when a new person is over the cross
int buffer=0;
int desiredBufferTime=0;
boolean triggeredInterface=false;

JSONArray eyePosData;
ArrayList<Eye> eyes = new ArrayList<Eye>();
ArrayList<String> oldData= new ArrayList<String>();
ArrayList<PVector> heads= new ArrayList<PVector>();
PVector debugNoise= new PVector(-10, -100, 100);

void setup() {
  frameRate(30);
  //make an eye for every json eye
  eyePosData = loadJSONArray("../EyePos.JSON");
  //Load the JSON setup file
  setUpData = loadJSONObject("../settings.JSON");
  JSONObject kinectData= setUpData.getJSONObject("Kinect");
  JSONObject screenData= setUpData.getJSONObject("Screen");
  JSONObject crossData= setUpData.getJSONObject("Cross");
  minimumDistToCross=crossData.getFloat("minimumDistance");
  desiredBufferTime=crossData.getInt("bufferFrames");
  kinectPos=new PVector(kinectData.getFloat("x"), kinectData.getFloat("y"), kinectData.getFloat("z")); 
  crossPos= new PVector (crossData.getFloat("x"), crossData.getFloat("y"), crossData.getFloat("z")); 
  screenPos=new PVector(screenData.getFloat("x"), screenData.getFloat("y"), screenData.getFloat("z"));

  screen=new Eye(screenPos, -1);
  time=0;

  //for (int i = 0; i < eyePosData.size(); i++) {
  //  JSONObject eye = eyePosData.getJSONObject(i);
  //  eyes.add(new Eye(new PVector(eye.getFloat("x"), eye.getFloat("y"), eye.getFloat("z")), eye.getInt("id")));
  //  oldData.add("");
  //}
  eyes.add(new Eye(new PVector(40, -100, 50), 0));
  oldData.add("");

  eyes.add(new Eye(new PVector(-40, -100, 50), 1));
  oldData.add("");

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
  sInterface=new Server(this, 10000);
  //if you wanna draw the 3d space setup lights etc
  if (draw) {
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
    port.bufferUntil('\n');
  }
}

void draw() {
  //if you wanna display: make the ground and lights and draw the green kinect dot
  if (draw) {
    //draw ground and lights
    drawAmbience();
    //draw kinect
    drawPoint(kinectPos, color (0, 255, 0));
    //draw CrossPosition
    drawPoint(crossPos, color (255, 0, 255));
    //draw screenEye
    screen.show();
    //show the eyes
    for (Eye eye : eyes) {
      eye.show();
    }
    //show the framerate counter
    fill(255, 0, 0);
    textSize(10);
    text(frameRate, 50, -50);
  }


  // Get the 3D data points from the 3D skeleton (access to Z point)
  ArrayList<KSkeleton> skeleton3DArray =  kinect.getSkeleton3d();

  //Empty the arraylist for all the heads tracked this frame
  heads = new ArrayList<PVector>();

  for (int i = 0; i < skeleton3DArray.size(); i++) {
    KSkeleton skeleton3D = (KSkeleton) skeleton3DArray.get(i);
    if (skeleton3D.isTracked()) {
      KJoint[] joints3D = skeleton3D.getJoints();
      PVector[] myJoints= new PVector[joints3D.length];
      //add every joint to the arraylist to draw and every head to the heads arraylist
      for (int j=0; j<joints3D.length; j++) {
        PVector jointPos=new PVector(joints3D[j].getX()*100, -joints3D[j].getY()*100, joints3D[j].getZ()*100);
        myJoints[j]=kinectPos.copy().add(jointPos.copy());
        if (draw) {
          if (j!=25) {
            drawPoint(myJoints[j], color(255, 0, 0));
          }
        }
        //if the point is the head add it to the arraylist
        if (j==3) {
          heads.add(myJoints[j]);
        }
      }
      //draw all the bones in this particular body
      if (draw) {
        drawBody(myJoints);
      }
    }
  }
  checkToStartInterface();
  //als er niemand getrackt word laat alle ogen een arbitrary punt (paars in het overview) volgen
  if (heads.size()<1) {
    displayNoise();
  }
  updatePhysicalEyesArduino();
  updateDigitalEyesTCP();
}

void serialEvent(Serial myPort) {
  if (debug) {
    byte[] incomingBytes = myPort.readBytes();
    char incomingChar= char(incomingBytes[0]);
    if (incomingChar=='w') {
      debugNoise.z-=2;
    } else if (incomingChar=='s') {
      debugNoise.z+=2;
    }

    if (incomingChar=='a') {
      debugNoise.x-=2;
    } else if (incomingChar=='d') {
      debugNoise.x+=2;
    }
  }
}

void drawAmbience() {
  ambientLight(255, 255, 255);
  background(255);
  pushMatrix();  
  rotateX(PI/2);
  translate(0, 0, 0);
  fill(0, 255, 0);
  rect(0, 0, 10000, 10000);
  popMatrix();
}

void displayNoise() {
  if (debug) {
    heads.add(debugNoise);
    drawPoint(debugNoise, color(255, 255, 255));
  } else {
    PVector noise=new PVector(map(noise(time/2), 0, 1, -50, 50), map(noise(time), 0, 1, -200, 0), map(noise(time*2), 0, 1, 0, 200));
    heads.add(noise);
    drawPoint(noise, color(255, 0, 255));
    time+=0.001;
  }
}

void checkToStartInterface() {
  //  int buffer=0;
  //int desiredBufferTime=0;
  //boolean triggeredInterface=false;
  float closestDist=999999999;
  for (int i=0; i<heads.size(); i++) {
    PVector head=heads.get(i);
    float distance=dist(crossPos.x, crossPos.z, head.x, head.z);
    if (distance<closestDist) {
      closestDist=distance;
    }
  }

  if (closestDist<=minimumDistToCross) {
    if (!triggeredInterface) {
      sInterface.write("Start"+'\n');
      print("Start"+'\n');
      triggeredInterface=true;
    }
  } else {
    buffer++;
    if (buffer>desiredBufferTime) {
      triggeredInterface=false;
      buffer=0;
    }
  }
}
void updateDigitalEyesTCP() {
  //Adjust the lookingPos for the screen by the difference between kinect and screenmid
  //update the lookingvector of the screen
  screen.update();
  //send the lookingvector over TCP to the eyeSketch
  PVector adjustedLookingPos=PVector.sub(screen.closestHead, screen.pos);
  String TCPpayload=""+adjustedLookingPos.x+","+adjustedLookingPos.y+","+adjustedLookingPos.z+"\n";
  //(x,y,z,'\n')
  //write the coords to the drawing sketch
  s.write(TCPpayload);
}

void updatePhysicalEyesArduino() {
  //update all the eyes, show if appropriate and send the data to the arduino
  String arduinoPayload="";
  for (int i=0; i<eyes.size(); i++) {
    Eye thisEye=eyes.get(i);
    thisEye.update();
    //stuur alleen de data als de hoeken verander zijn
    String thisArduinoPayload=thisEye.id+","+int(thisEye.angleY)+","+int(thisEye.angleZ)+"|";
    if (!oldData.get(i).equals(thisArduinoPayload)) {
      arduinoPayload+=thisArduinoPayload;
      oldData.set(i, thisArduinoPayload);
    }
  }
  if (arduinoPayload.length()>=1) {
    //dont update 60 frames per second!
    if (useArduino&&frameCount%2==0) {
      port.write(arduinoPayload);
    }
  }
}

void keyPressed() {
  if (key=='d') {
    debug=!debug;
  }

  if (debug) {
    if (keyCode==UP) {
      debugNoise.y+=5;
    } else if (keyCode==DOWN) {
      debugNoise.y-=5;
    }
  }
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
