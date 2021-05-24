import processing.net.*;
Client c;
int amount = 2000;
float area;
float areaEyes = 0;
float counter = 0;
float time = 0;
float distToScreen = 200;
PVector lookingPosition;
PImage centerEyeIris;
PImage[] eyeImages=new PImage[50];
float noiseFactor = 0.01;
int screenWidthCM=100;
float swPixDIVswCM;
int blinkFrameCount=0;

//zet deze boolean op false om je mouseposition te pakken
Boolean server=false;
Boolean useImages=false;

ArrayList <Eye> eyes = new ArrayList <Eye>();
int frameCounter;
String ontvangen="";

void setup() {
  if (server) {
    c = new Client(this, "127.0.0.1", 10001);//listening port and ip
    lookingPosition=new PVector(0, 0);
  }
  fullScreen(1);
  swPixDIVswCM=width/screenWidthCM;
  if (useImages) {
    imageMode(CENTER);
    for (int i=0; i<50; i++) {
      String path="./onlyEyes/eye"+i+".png";
      eyeImages[i]=loadImage(path);
    }
    centerEyeIris = loadImage("centerEyeIris.png");
  }
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
  background(0);
  time +=1;

  //everything for server
  if (server) {
    if (c.available() > 0) { // receive data
      ontvangen=c.readString();
      String[] temp=split(ontvangen, "\n");
      ontvangen=temp[0];
      temp=split(ontvangen, ",");
      //ontvangen= (x, y, z) 
      //ontvangen=in meters;
      //to convert to pixels do meters times pixels/meters ratio and add half the screen
      float x=float(temp[0])*swPixDIVswCM;
      float y=float(temp[1])*swPixDIVswCM;
      float z=float(temp[2])*swPixDIVswCM;
      lookingPosition=PVector.add(new PVector(x, y, z), new PVector(width/2, height/2));
    }
  } else {
    lookingPosition=new PVector(mouseX, mouseY, distToScreen);
  }

  //draw eyes
  for (Eye eye : eyes) {
    eye.update(lookingPosition);
    eye.display();
  }
  //make the eyes blink by per a random amount of frames
  if (frameCount>blinkFrameCount) {
    PVector blink=new PVector(random(width), random(height));
    blinkFrameCount=frameCount+int(random(10, 50));
    for (Eye eye : eyes) {
      eye.checkToGoBlink(blink);
    }
  }
}

void mouseWheel(MouseEvent event) {
  //change the distance to screen by scrolling mousewheel
  float delta = event.getCount();
  if ((delta < 0 && distToScreen > 0) || (delta > 0 && distToScreen < 200000)) distToScreen += delta*100;
  println(distToScreen);
}
