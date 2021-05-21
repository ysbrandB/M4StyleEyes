//images by https://www.freepik.com, from https://www.flaticon.com

JSONArray eyePosData;
Calibration CalibrationScreen;
PVector screenPos;
PImage screenImg;
PImage eyeImg;
ButtonHandler buttonHandler;


void setup() {
  size(800, 800, P2D);

  screenImg = loadImage("tv.png");
  eyeImg = loadImage("eye.png");
  screenImg.resize(width/4, 0);
  eyeImg.resize(width/8, 0);

  eyePosData = loadJSONArray("../EyePos.JSON");
  screenPos = new PVector(width/2, 100);
  CalibrationScreen = new Calibration(eyePosData);
  buttonHandler = new ButtonHandler();
}

void draw() {
  background(150);

  buttonHandler.update();
  buttonHandler.display();

  pushMatrix();
  translate(screenPos.x, screenPos.y);
  rectMode(CENTER);
  imageMode(CENTER);
  image(screenImg, 0, -height/20);

  CalibrationScreen.update(mouseX, mouseY);
  CalibrationScreen.display();
  popMatrix();
}

void mousePressed() {
  CalibrationScreen.clicked(mouseX, mouseY);
}

//TODO
// -calibrate in x,y,z
// - with top view
// - save in json ofzo

//Hoi
