/*
A sketch by Ysbrand Burgstede to test the arduino, driver boards and serial communcation of the eyes by mapping the mousePosition
 to the angles of the eyes*/

static final int ARDUINOPORT=1;
//serial library for arduino communication
import processing.serial.*;
Serial port;
boolean arduinoConnected=false;
int minAngleX=45;
int maxAngleX=135;

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
  println(""+int(map(mouseX, 0, width, minAngleX, maxAngleX))+","+int(map(mouseY, 0, height, minAngleY, maxAngleY)));
  String arduinoPayload="";
  for (int i=0; i<=6; i++) {
    arduinoPayload+=i+","+int(map(mouseX, 0, width, minAngleX, maxAngleX))+","+int(map(mouseY, 0, height, minAngleY, maxAngleY))+"|";
   // println(arduinoPayload);
  }
  //send the payload to the arduino
  if (arduinoPayload.length()>=1&&frameCount%60==0) {
    try {
      port.write(arduinoPayload);
    }
    catch(Exception e) {
      if (frameCount%1==0) {
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
    port = new Serial(this, Serial.list()[ARDUINOPORT], 9600);
    port.bufferUntil('\n');
    arduinoConnected=true;
    println("EyeArduino Connected!");
  }
  catch(Exception e) {
    arduinoConnected=false;
    println("EyeArduino not Connected!");
  }
}
