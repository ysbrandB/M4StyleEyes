import processing.net.*;
Client c;
int amount = 2000;
float area;
float areaEyes = 0;
float counter = 0;
float distToScreen = 200;
PVector lookingPosition;
PImage eyeIris;

//zet deze boolean op false om je mouseposition te pakken
Boolean server=false;

ArrayList <Eye> eyes = new ArrayList <Eye>();
int frameCounter;
String ontvangen="";
void setup() {
  if (server) {
    c = new Client(this, "127.0.0.1", 10001);//listening port and ip
    lookingPosition=new PVector(0, 0);
  }
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
  if (server) {
    if (c.available() > 0) { // receive data
      ontvangen=c.readString();
      String[] temp=split(ontvangen, "\n");
      ontvangen=temp[0];
      temp=split(ontvangen, ",");
      //ontvangen= (x, y, FaceWidth, screenWidth, screenHeight) 
      float x=map(int(temp[0]), 0, int(temp[3]), width, 0);
      float y=map(int(temp[1]), 0, int(temp[4]), 0, height);
      float z=map(int(temp[2]), 50, 350, 2500, 5000);
      lookingPosition=new PVector(x, y, z);
    }
  } else {
    lookingPosition=new PVector(mouseX, mouseY, distToScreen);
  }
  
  background(0);

  for (Eye eye : eyes) {
    eye.update(lookingPosition);
    eye.display(eyeIris);
  }
}

void mouseWheel(MouseEvent event) {
  float delta = event.getCount();
  if ((delta < 0 && distToScreen > 0) || (delta > 0 && distToScreen < 200000)) distToScreen += delta*100;
  println(distToScreen);
}
void mousePressed() {
  print(distToScreen);
}
