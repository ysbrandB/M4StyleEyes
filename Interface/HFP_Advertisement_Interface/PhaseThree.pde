class PhaseThree extends Slide {

  PFont mainText; //font for main the main text
  
  Strings string;

  PhaseThree(PFont pThreeMainText) {
    string = new Strings();
    mainText = pThreeMainText;
  }

  void display() {
    background(bgColor);

    textFont(mainText);
    fill(0);
    string.Brands();
  }
}
