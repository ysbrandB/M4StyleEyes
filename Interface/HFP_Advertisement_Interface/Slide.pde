//the super class of all slides: PhaseZero, PhaseOne, PhaseTwo & PhaseThree
class Slide {

  color bgColor; //gives the background color
  boolean isFinished;

  Slide() {

    bgColor = color(192, 200, 206);
    isFinished = false;
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
