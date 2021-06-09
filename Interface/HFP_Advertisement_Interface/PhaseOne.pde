class PhaseOne extends Slide {

  String upperText;
  String lowerText;

  String recogText;
  String clothColorRecog;
  String clothRecog;
  String recomStartText;
  String clothColorRecom;
  String clothRecom;
  String recomEndText;

  PImage recomClothing; 
  ColorPicker colorPicker;

  ColorPicker colorPicker;
  TypePicker typePicker;

  PhaseOne(ColorPicker colorPicker, TypePicker typePicker) {
    this.colorPicker = colorPicker;
    this.typePicker= typePicker;
  }

  void display() {
    background(bgColor);
    fill(0);
    //colorPicker = new ColorPicker(222,5,0);
    //colorPicker.update();

  void display() {
    background(bgColor);
    fill(0);
    colorPicker = new ColorPicker(222,5,0);
    colorPicker.update();

    recogText = "You are wearing a" + '\n';
    clothColorRecog = colorPicker.getLastColorName();
    clothRecog = typePicker.getLastTypeName();

    recomStartText = "However, these days" + '\n'; 
    clothColorRecom = colorPicker.getLastOppositeColorName();
    clothRecom = typePicker.getLastOppositeTypeName();
    recomEndText = " are far more" + '\n' + "fashionable";

    lowerText = clothRecom + recomEndText; 

    recomClothing = loadImage("image/whitepolo.png");

    textFont(fontHeading);

    text(recogText, width/8, height/4);
    fill(colorPicker.getLastColor());
    text(clothColorRecog, width/8, height/4 +80);
    fill(0);
    text(clothRecog, width/8, height/4 +160);

    text(recomStartText, width/8, height/8*5);
    fill(colorPicker.getLastOppositeColor());
    text(clothColorRecom, width/8, height/8*5 + 80);
    fill(0);
    text(lowerText, width/8, height/8*5 + 160);

    image(recomClothing, width/4*3, height/2);
  }
}
