/*
A sketch by Ysbrand Burgstede to test the arduino, driver boards and serial communcation of the eyes by mapping the mousePosition
 to the angles of the eyes*/

static final int ARDUINOPORT=1;
//serial library for arduino communication
import processing.serial.*;
Serial leftPort;
Serial rightPort;
int minAngleX=45;
int maxAngleX=135;

int rightArduinoPortNumber=2;
int leftArduinoPortNumber=1;

int minAngleY=80;
int maxAngleY=100;
float xRes;
float yRes;

void setup() {
  //print the available serial (arduino ports)
  println("Available serial ports:");
  for (int i = 0; i<Serial.list().length; i++) { 
    print("[" + i + "] ");
    println(Serial.list()[i]);
  }
  //init the port
  connectArduino();

  size(1000, 1000);
  xRes=width/(maxAngleX-minAngleX);
  yRes=height/(maxAngleY-minAngleY);
  textMode(CENTER);
}

void draw() {
  background(255);
  fill(0);
  //draw the lines
  for (int i=0; i<height; i+=int(yRes)) {
    line(0, i, height, i);
  }
  for (int i=0; i<width; i+=int(xRes)) {
    line(i, 0, i, width);
  }
  //draw the anglenumbers
  for (int i=0; i<height; i+=int(yRes)) {
    text(int(map(i, 0, height, minAngleY, maxAngleY)), 20, i);
  }
  for (int i=0; i<width; i+=int(xRes)*3) {
    text(int(map(i, 0, width, minAngleX, maxAngleX)), i, 20);
  }

  //print the angles you are sending
  //println(""+int(map(mouseX, 0, width, minAngleX, maxAngleX))+","+int(map(mouseY, 0, height, minAngleY, maxAngleY)));
  for (int i=0; i<=6; i++) {
    String arduinoPayload="<"+i + "," + i+"," +int(map(mouseX, 0, width, minAngleX, maxAngleX))+","+int(map(mouseY, 0, height, minAngleY, maxAngleY))+">";
    println("Processing sends:" +arduinoPayload);
    try {
      if (i<3) {
        leftPort.write(arduinoPayload);
      } else {
        rightPort.write(arduinoPayload);
      }
    }
    catch(Exception e) {
      if (frameCount%360==0) {
        connectArduino();
      }
    }
  }
}


void serialEvent(Serial p) { 
  println(p.readString());
} 


void connectArduino() {
  try {
    leftPort = new Serial(this, Serial.list()[leftArduinoPortNumber], 9600);
    leftPort.bufferUntil('\n');
    println("LeftEyeArduino Connected!");
  }
  catch(Exception e) {
    println("LeftEyeArduino not Connected!");
  }
  try {
    rightPort = new Serial(this, Serial.list()[rightArduinoPortNumber], 9600);
    rightPort.bufferUntil('\n');
    println("RightEyeArduino Connected!");
  }
  catch(Exception e) {
    println("rightEyeArduino not Connected!");
  }
}
