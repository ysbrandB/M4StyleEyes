
int amount = 100;
Eye centerEye;
Eye [] smallerEyes = new Eye[amount];

void setup() {
  size(1920, 1080);
  centerEye = new Eye(width/2, height/2, 400);

  for (int i = 0; i < smallerEyes.length; i++) {
    smallerEyes[i] = new Eye(random(width), random(height), random(50, 200));
  }
}

void draw() {
  background(124);
  centerEye.display(mouseX, mouseY);
  centerEye.update();

  for (int i = 0; i < smallerEyes.length; i++) {
    smallerEyes[i].display(mouseX, mouseY);
    smallerEyes[i].update();
  }
}
