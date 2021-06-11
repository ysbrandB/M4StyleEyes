//images by https://www.freepik.com, from https://www.flaticon.com
//TODO:
//distanceMeter aanpassen door erop te klikken en dat je het oog dan ook niet unselect

JSONArray eyePosData;
Calibration CalibrationScreen;
PVector screenPos;
PImage screenImg;
PImage eyeImg;
ButtonHandler buttonHandler;
float zoom = 1;
String dataPath = "../EyePos.JSON";

void setup() {
  size(800, 800, P2D);

  screenImg = loadImage("tv.png");
  eyeImg = loadImage("eye.png");
  screenImg.resize(width/4, 0);
  eyeImg.resize(width/8, 0);

  eyePosData = loadJSONArray(dataPath);
  screenPos = new PVector(width/2, 100);
  CalibrationScreen = new Calibration(eyePosData);
  buttonHandler = new ButtonHandler();
}

void draw() {
  background(175);

  buttonHandler.update(mouseX, mouseY);
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

void safe(){
  JSONArray dataArray = new JSONArray();;
  for(int i = 0; i<CalibrationScreen.eyes.size(); i++){
    Eye eye = CalibrationScreen.eyes.get(i);
    JSONObject eyeObj = new JSONObject();
    eyeObj.setFloat("id", i);
    eyeObj.setFloat("x", eye.pos.x);
    eyeObj.setFloat("y", eye.pos.y);
    eyeObj.setFloat("z", eye.pos.z);
    dataArray.setJSONObject(i, eyeObj);
  }
  println(dataArray);
  saveJSONArray(dataArray, dataPath);
}

void mousePressed() {
  CalibrationScreen.clicked(mouseX, mouseY);
  buttonHandler.clicked(mouseX,mouseY);
}

void mouseWheel(MouseEvent event) {
  float delta = event.getCount();
  zoom += delta * 0.1;
  if(zoom <= 0.1) zoom = 0.1;
}

void mouseDragged() {
  CalibrationScreen.dragged(mouseX,mouseY);
}

void mouseReleased() {
  CalibrationScreen.mouseRelease();
}