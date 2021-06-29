class PhaseOne extends Slide {
  CommunicationHandler com;
  PImage img;
  int colorFade;
  int rotation;
  IntList trail = new IntList();
  Eye eye;
  float timer;
  float timePerStep;
  int eyeRadius;

  PhaseOne(CommunicationHandler com) {
    this.com = com;
    eyeRadius = 200;
    eye = new Eye(width/2, height/2, eyeRadius);
    colorFade = 200;
    rotation = 0;
    trail.append(rotation);
    timePerStep = 0.1;
    timer = timePerStep;
  }

  void init() {
    com.ledstripScan();
  }

  void display() {
    background(bgColor);
    textSize(45);
    textAlign(CENTER, CENTER);
    eye.display();
    pushMatrix();
    translate(width/2, height/2);
    for (int i = 0; i<trail.size(); i++) {
      pushMatrix();
      noStroke();
      rotate(radians(trail.get(i)));
      fill(0, 255/trail.size()*float(i + 1));
      rect(0, eyeRadius* 0.53, eyeRadius/11, eyeRadius/3);
      popMatrix();
    }

    if (timer <=0) {
      trail.append(rotation);
      timer = timePerStep;

      if (trail.size() > 5) trail.remove(0);
      rotation+=24;
    }
    popMatrix();

    timer -= 1/frameRate;
    fill(255);
    textFont(fontHeading);
    text("Scanning...", width/2, height/20*17);
    text("Let me St-EYE-le you!", width/2, height/10);
  }
}
