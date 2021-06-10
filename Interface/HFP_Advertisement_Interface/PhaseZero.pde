class PhaseZero extends Slide {
  
  CommunicationHandler com;

  PhaseZero(CommunicationHandler com) {
    bgColor = color(0, 0, 0);
    this.com = com;
  }

  void display() {
    background(bgColor);
    fill(255);
    text(com.clothingType + " " + com.clothingColor + " " + com.hits, 50, 50);
  }
}
