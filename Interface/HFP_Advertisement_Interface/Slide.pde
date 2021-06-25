//the super class of all slides: PhaseZero, PhaseOne, PhaseTwo & PhaseThree
class Slide {

  color bgColor = color(0, 0, 0); //gives the background color
  boolean isFinished = false;

  PFont fontHeading;
  PFont fontSub;

  Slide() {
    fontHeading = createFont("Font/ARLRDBD_0.TTF", height/25); //Arial rounded MT Bold
    fontSub = createFont("Font/ARLRDBD_0.TTF", height/30); //Arial rounded MT Bold
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
