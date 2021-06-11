class PhaseOne extends Slide {

  // String upperText;
  // String lowerText;

  // String recogText;
  // String clothColorRecog;
  // String clothRecog;
  // String recomStartText;
  // String clothColorRecom;
  // String clothRecom;
  // String recomEndText;
  Strings string;

  PImage recomClothing; 

  PFont MainText; //Font for the main text
   ColorPicker colorPicker;
   TypePicker typePicker;

  PhaseOne(ColorPicker colorPicker, TypePicker typePicker) {
    string = new Strings();

     MainText = createFont("Font/ARLRDBD_0.TTF", 80); //lettertype Arial rounded MT Bold
     this.colorPicker = colorPicker;
     this.typePicker= typePicker;
     recomClothing = loadImage("image/whitepolo.png");
     textFont(MainText);
  }

  void display() {
    background(bgColor);
    fill(0);
    textAlign(CENTER);
    string.BeginMessage();

    image(recomClothing, width/4*3, height/2);
     //colorPicker = new ColorPicker(222,5,0);
     //colorPicker.update();

     //recogText = "You are wearing a" + '\n';
     //clothColorRecog = colorPicker.getLastColorName();
     //clothRecog = typePicker.getLastTypeName();

     //recomStartText = "However, these days" + '\n'; 
     //clothColorRecom = colorPicker.getLastOppositeColorName();
     //clothRecom = typePicker.getLastOppositeTypeName();
     //recomEndText = " are far more" + '\n' + "fashionable";

     //lowerText = clothRecom + recomEndText; 

     //textFont(fontHeading);

     //text(recogText, width/8, height/4);
     //fill(colorPicker.getLastColor());
     //text(clothColorRecog, width/8, height/4 +80);
     //fill(0);
     //text(clothRecog, width/8, height/4 +160);

     //text(recomStartText, width/8, height/8*5);
     //fill(colorPicker.getLastOppositeColor());
     //text(clothColorRecom, width/8, height/8*5 + 80);
     //fill(0);
     //text(lowerText, width/8, height/8*5 + 160);
  }
}
