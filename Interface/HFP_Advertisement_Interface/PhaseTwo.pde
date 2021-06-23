class PhaseTwo extends Slide {

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
  Eye eye;
  int xTime=0;

  PImage recomClothing; 

  PFont MainText; //Font for the main text
  ColorPicker colorPicker;
  TypePicker typePicker;

  PhaseTwo(ColorPicker colorPicker, TypePicker typePicker) {
    eye= new Eye(width/4, height/4, 30);
    MainText = createFont("Font/ARLRDBD_0.TTF", 80); //lettertype Arial rounded MT Bold
    this.colorPicker = colorPicker;
    this.typePicker= typePicker;
    recomClothing = loadImage("image/whitepolo.png");
    textFont(MainText);
  }

  void init(CommunicationHandler com) {
    string = new Strings(colorPicker);
    com.sendColor(colorPicker.getLastColor());
  }

  void display() {    

    background(bgColor);
    fill(0);
    rectMode(BASELINE);
    textAlign(CENTER);
    string.BeginMessage();
    //eye.display();
    //xTime+=0.001;
    //eye.update(new PVector(map(noise(xTime*2),0,1,0,width), map(noise(xTime),0,1,0,height)));

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
