class PhaseZero extends Slide {
  
  CommunicationHandler com;

  PhaseZero(CommunicationHandler com) {
    bgColor = color(0, 0, 0);
    this.com = com;
  }

  void display() {
    background(bgColor);
    fill(255);
    textSize(45);
    textAlign(TOP, LEFT);
    text(com.clothingType + " [" + red(com.clothingColor) + "," + green(com.clothingColor) + "," + blue(com.clothingColor) + "] " + com.hits, 50, 50);
  }
}
