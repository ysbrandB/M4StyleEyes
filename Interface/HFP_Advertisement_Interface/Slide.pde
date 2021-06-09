//the super class of all slides: PhaseZero, PhaseOne, PhaseTwo & PhaseThree
class Slide {

  color bgColor = color(192, 200, 206); //gives the background color
  boolean isFinished = false;
  
  PFont fontHeading;
  PFont fontSub;

  Slide() {
    fontHeading = createFont("Font/ARLRDBD_0.TTF", 80); //Arial rounded MT Bold
    fontSub = createFont("Font/ARLRDBD_0.TTF", 40); //Arial rounded MT Bold
  }

  void display() {
    background(bgColor);
  }

  boolean isFinished() {
    return isFinished = true;
  }

  boolean countUpdated() {
    return isFinished = false;
  }
}
