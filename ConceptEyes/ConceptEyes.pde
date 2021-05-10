import processing.net.*;
Client c;
int amount = 2000;
float area;
float areaEyes = 0;
float counter = 0;
float distToScreen = 200;
PVector lookingPosition;
PImage eyeIris;

ArrayList <Eye> eyes = new ArrayList <Eye>();
int frameCounter;

void setup() {
  c = new Client(this, "127.0.0.1", 10000);//listening port and ip
  frameCounter=0;
  lookingPosition=new PVector(0,0);
  size(1920, 1080);
  //fullScreen();
  imageMode(CENTER);
  eyeIris = loadImage("eyeIris.png");
  eyes.add(new Eye(width/2, height/2, 400));

  area = width * height;
  for (int i = 0; i < amount; i ++) {
    eyes.add(new Eye());
    counter++;
    if (areaEyes/area >= 0.3) {
      println("henkie");
      break;
    }
  }  
  println(counter);
}


void draw() {
  lookingPosition=new PVector(mouseX, mouseY, distToScreen);
  
  if (frameCounter%10==0) {
    if (c.available() > 0) { // receive data
      println("client received: " +c.readString());
    }
  }
  frameCounter++;

  background(0);

  for (Eye eye : eyes) {
    eye.update(lookingPosition);
    eye.display(eyeIris);
  }
}

void mouseWheel(MouseEvent event) {
  float delta = event.getCount();
  if ((delta < 0 && distToScreen > 0) || (delta > 0 && distToScreen < 2000)) distToScreen += delta*100;
  //println(distToScreen);
}
