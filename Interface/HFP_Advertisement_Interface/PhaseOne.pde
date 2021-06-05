class PhaseOne extends Slide {

  PFont mainText;

  // String upperText;
  // String lowerText;

  // String recogText;
  // String clothRecog;
  // String recomStartText;
  // String clothRecom;
  // String recomEndText;
  Strings string;

  PImage recomClothing; 


  PhaseOne(PFont pONeMainText) {
    //bgColor = color(255,0,0);
    string = new Strings();
    mainText = pONeMainText;

    // recogText = "You are wearing a" + '\n';
    // clothRecog = "Blue Sweater";

    // recomStartText = "However, these days" + '\n'; 
    // clothRecom = "White Polos";
    // recomEndText = " are far" + '\n' +  "more fashionable";

    // upperText = recogText + clothRecog;
    // lowerText = recomStartText + clothRecom + recomEndText;

    recomClothing = loadImage("image/whitepolo.png");
  }

  void display() {
    background(bgColor);
    fill(0);

    textFont(mainText);
    // text(upperText, width/8, height/4);
    // text(lowerText, width/8, height/8*5);
    string.BeginMessage();

    image(recomClothing, width/4*3, height/2);
  }
}
