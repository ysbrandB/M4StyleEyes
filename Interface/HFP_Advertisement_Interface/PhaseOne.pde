class PhaseOne extends Slide {

  PFont mainText;

  String upperText;
  String lowerText;

  String recogText;
  String clothRecog;
  String recomStartText;
  String clothRecom;
  String recomEndText;

  PImage recomClothing; 
  ColorPicker colorPicker;

  PhaseOne(PFont pONeMainText) {
    //bgColor = color(255,0,0);
    mainText = pONeMainText;
  }

  void display() {
    background(bgColor);
    fill(0);
    colorPicker = new ColorPicker(222,5,0);
    colorPicker.update();

    recogText = "You are wearing a" + '\n';
    clothRecog = colorPicker.getDeterminedColorName() + " Sweater";

    recomStartText = "However, these days" + '\n'; 
    clothRecom = colorPicker.getOpositeDeterminedColorName() + " Polos";
    recomEndText = " are far" + '\n' +  "more fashionable";

    upperText = recogText + clothRecog;
    lowerText = recomStartText + clothRecom + recomEndText;

    recomClothing = loadImage("image/whitepolo.png");

    textFont(mainText);

    text(upperText, width/8, height/4);
    text(lowerText, width/8, height/8*5);

    image(recomClothing, width/4*3, height/2);
  }
}
