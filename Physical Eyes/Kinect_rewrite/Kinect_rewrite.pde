//3d cam library
import peasy.*;
PeasyCam camera;

//kinect library
import KinectPV2.KJoint;
import KinectPV2.*;

//serial library for arduino communication
import processing.serial.*;
//TCP communication with eyes
import processing.net.*;

MyKinect myKinect;
PhysicalEyes physicalEyes;
Cross cross;
Screen screen;

JSONObject setUpData;
ArrayList <Body> bodies;
ArrayList <PVector> heads;
boolean debug=false;

DebugNoise noise1;
DebugNoise noise2;
float time=0;
boolean triggeredInterface=false;

int rightArduinoPortNumber=0;
int leftArduinoPortNumber=2;

void setup() {
  size(1000, 1000, P3D);
  perspective(PI/3.0, width/height, 1, 10000);
  sphereDetail(1);
  rectMode(CENTER);
  frameRate(30);

  //make a new cam element
  camera = new PeasyCam(this, -2, 0, -1, 100);
  bodies=new ArrayList <Body>();
  heads=new ArrayList <PVector>();
  //Load the JSON setup file
  setUpData = loadJSONObject("../settings.JSON");
  println("Loaded JSON data and created camera");

  myKinect=new MyKinect(this, setUpData);
  physicalEyes=new PhysicalEyes(this, myKinect.getPos());
  cross=new Cross(this, setUpData);
  screen=new Screen(this, setUpData, myKinect.getPos());
  println("setup kinect");

  noise1=new DebugNoise(new PVector(-20, -100, 100));
  noise2=new DebugNoise(new PVector(+20, -100, 100));

  //print the available serial (arduino ports)
  println("Available serial ports:");
  for (int i = 0; i<Serial.list().length; i++) { 
    print("[" + i + "] ");
    println(Serial.list()[i]);
  }
}

void draw() {
  //reset the bodies and heads in the scene!
  bodies=new ArrayList <Body>();
  heads=new ArrayList <PVector>();
  //draw the environment
  drawEnvironment();
  //retrieve the bodies from the kinect
  myKinect.show();
  myKinect.updateBodies();
  
  //check if interface can be started and if so update it over tcp
  cross.show();
  cross.update();

  //add the debug heads to the scene
  if (debug) {
    noise1.show();
    noise2.show();
  } else if (heads.size()<1) {
    PVector noise=new PVector(map(noise(time/2), 0, 1, -screen.getHalfPhysicalScreenWidth(), screen.getHalfPhysicalScreenWidth()), map(noise(time), 0, 1, 0, -(((screen.getHalfPhysicalScreenWidth()*2)/16)*9))-100, map(noise(time*2), 0, 1, 0, screen.getHalfPhysicalScreenWidth()*2));
    heads.add(noise);
    drawPoint(noise, color(255, 0, 255));
    time+=0.001;
  }
  //update the physical eyes over arduino and calculate the angles
  physicalEyes.show();
  //physicalEyes.update();

  //update the digital eyes over tcp
  screen.show();
  screen.update();

  //show all the bodies
  for (Body body : bodies) {
    body.show();
  }
  //show the framerate counter
  fill(255, 0, 0);
  textSize(10);
  text(frameRate, 50, -50);
}

void drawEnvironment() {
  ambientLight(255, 255, 255);
  background(255);
  pushMatrix();  
  rotateX(PI/2);
  translate(0, 0, 0);
  if (triggeredInterface) {
    fill(255, 100, 100);
  } else {
    fill(0, 255, 0);
  }
  rect(0, 0, 10000, 10000);
  popMatrix();
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

void keyPressed() {
  if (key=='e') {
    debug=!debug;
  }
  if (key==CODED) {
    noise1.changeDirection(key, true);
  } else {
    noise2.changeDirection(key, true);
  }
}
void keyReleased() {
  if (key==CODED) {
    noise1.changeDirection(key, false);
  } else {
    noise2.changeDirection(key, false);
  }
}
