
int amount = 2000;
float area;
float areaEyes = 0;
float distToScreen = 200;

ArrayList <Eye> eyes = new ArrayList <Eye>();


void setup() {
  size(1920, 1080);
  //fullScreen();
  
  eyes.add(new Eye(width/2, height/2, 400));

  area = width * height;
  
  for (int i = 0; i < amount; i ++) {
    eyes.add(new Eye());
    if (areaEyes/area >= 0.3) {
      break;
    }
  }  
}


void draw() {
  background(0);

  for (Eye eye : eyes) {
    eye.update(mouseX, mouseY);
    eye.display();
  }
}

void mouseWheel(MouseEvent event) {
  float delta = event.getCount();
  if ((delta < 0 && distToScreen > 0) || (delta > 0 && distToScreen < 2000)) distToScreen += delta*100;
  println(distToScreen);
}

void mousePressed() {
  //for (Eye eye : eyes) {
  //  eye.blinkEye();
  //}
}
