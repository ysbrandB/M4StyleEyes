class PhaseOne extends Slide {

  CommunicationHandler com;
  PImage img;
  PVector irisPos;
  int colorFade;
  int rotation;
  IntList trail = new IntList();

  PhaseOne(CommunicationHandler com) {
    this.com = com;
    img = loadImage("./Image/bigEye.png");
    imageMode(CENTER);
    irisPos = new PVector(width/2, height/2);
    colorFade = 200;
    rotation = 0;
    trail.append(rotation);
    textAlign(CENTER, CENTER);
  }

  void display() {
    background(bgColor);
    fill(255);
    textSize(45);
    textAlign(TOP, LEFT);
    fill(255);
    ellipse(irisPos.x, irisPos.y, width/2.6, height/2);
    textAlign(CENTER, CENTER);
    imageMode(CENTER);
    image(img, width/2, height/2, height, height);

    fill(0);
    circle(irisPos.x, irisPos.y, height/4);
      pushMatrix();
      translate(width/2, height/2);
      for (int i = 0; i<trail.size(); i++) {
        pushMatrix();
        rotate(radians(trail.get(i)));
        fill(255, 255/trail.size()*float(i + 1));
        rect(0, -height/12, height/60, height/15);
        popMatrix();
      }
      trail.append(rotation);
      if (trail.size() > 4) trail.remove(0);
      rotation+=24;
      popMatrix();
      fill(0);
      text("Scanning...", width/2, height/20*17);

      fill(0);
      textFont(fontHeading);
      text("Let me St-EYE-le you!", width/2, height/10);
  }
}
