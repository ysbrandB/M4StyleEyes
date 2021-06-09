class PhaseZero extends Slide {
  
  CommunicationHandler handler;

  PhaseZero(CommunicationHandler handler) {
    bgColor = color(0, 0, 0);
    this.handler = handler;
  }

  void display() {
    background(bgColor);
    fill(255);
    text(handler.clothingType + " " + handler.clothingColor + " " + handler.hits, 50, 50);
  }
}
