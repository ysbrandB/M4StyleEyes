//images by https://www.freepik.com, from https://www.flaticon.com

JSONArray eyePosData;
Calibration CalibrationScreen;
boolean isCalibration;
PVector screenPos;
PImage screenImg;
PImage eyeImg;


void setup() {
  size(800, 800, P2D);

  screenImg = loadImage("tv.png");
  eyeImg = loadImage("eye.png");
  screenImg.resize(width/4,0);
  eyeImg.resize(width/8,0);
  imageMode(CENTER);
  
  eyePosData = loadJSONArray("EyePos.JSON");
  screenPos = new PVector(width/2,100);
  CalibrationScreen = new Calibration(eyePosData);
  isCalibration = true;
 
  
  

  //println(eyePosData);
}

void draw() {
  background(150);
  pushMatrix();
  translate(screenPos.x,screenPos.y);
  rectMode(CENTER);
  image(screenImg,0,-height/20);
  //fill(0,150);
  //rect(0,0,width/5,height/10);// moet later nog iets leuks worden, een foto ofzo
  
  if (isCalibration) {
    CalibrationScreen.update(mouseX, mouseY);
    CalibrationScreen.display();
  }
  popMatrix();
}

void mousePressed(){
  CalibrationScreen.clicked(mouseX, mouseY);
}

//TODO
// -calibrate in x,y,z
// - with top view
// - save in json ofzo

//Hoi
