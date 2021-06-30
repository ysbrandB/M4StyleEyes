class PhaseOne extends Slide {
  CommunicationHandler com;
  Eye eye;
 

  PhaseOne(CommunicationHandler com) {
    this.com = com;
    eye = new LoadEye(width/2, height/2, 200);
  }

  void init() {
    com.ledstripScan();
  }

  void display() {
    background(bgColor);
    textSize(45);
    textAlign(CENTER, CENTER);
    eye.display();
    eye.update(com.lookingPositions);
    fill(255);
    textFont(fontHeading);
    text("Scanning...", width/2, height/20*17);
    text("Let me St-EYE-le you!", width/2, height/10);
  }
}
