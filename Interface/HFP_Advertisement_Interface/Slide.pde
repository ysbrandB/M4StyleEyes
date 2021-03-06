//the super class of all slides: PhaseZero, PhaseOne, PhaseTwo & PhaseThree
class Slide {

  color bgColor = color(0, 0, 0); //gives the background color
  boolean isFinished = false;

  PFont fontHeading;
  PFont fontSub;
  PFont SegoeBold21;
  PFont Segoe31;
  PFont SegoeSemiBold19;
  PFont MainText; //Font for the main text
  PFont typeWriterText;

  Slide() {
    fontHeading = createFont("Font/ARLRDBD_0.TTF", height/25); //Arial rounded MT Bold
    fontSub = createFont("Font/ARLRDBD_0.TTF", height/30); //Arial rounded MT Bold
    SegoeBold21 = createFont("Segoe UI Bold", 21); //for tweet
    Segoe31 = createFont("Segoe UI", 28); //for tweet
    SegoeSemiBold19 = createFont("Segoe UI Semibold", 19); //for tweet
    MainText = createFont("Font/Typewriter.otf", height/30); //lettertype Arial rounded MT Bold
    typeWriterText = createFont("Font/Typewriter.otf", height/6);
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
