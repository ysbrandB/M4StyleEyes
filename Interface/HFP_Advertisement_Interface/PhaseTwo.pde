class PhaseTwo extends Slide {
  String Message;
  //Strings string;
  Eye eye;
  int xTime=0;

  PImage recomClothing;
  PImage bigEyeSlides;
  JSONObject startMsg;
  PFont MainText; //Font for the main text
  ColorPicker colorPicker;
  TypePicker typePicker;
   String[] text;
  PhaseTwo(ColorPicker colorPicker, TypePicker typePicker, JSONObject data) {
    eye= new Eye(width/4, height/4, 30);
    MainText = createFont("Font/Typewriter.otf", height/25); //lettertype Arial rounded MT Bold
    this.colorPicker = colorPicker;
    this.typePicker= typePicker;
    bigEyeSlides = loadImage("image/bigEyeSlides.png");
    recomClothing = loadImage("image/Clothing/White.T-Shirt.png");
    
    JSONArray startMsg = data.getJSONArray("startMsg"); //Gets the text for the begin message
    text = startMsg.getStringArray(); //Splits the messages
    
  }

  void init(CommunicationHandler com) {
    //string = new Strings(colorPicker);
    com.sendColor(colorPicker.getLastColor());
    
    Message = text[int(random(0,text.length))]; //Sets 'Message' to one of the stings with the number from s
    Message = Message.replace("ColorQ_", colorPicker.getLastColorName()); //Replaces the word 'Color_' by the text at beginColor
    Message = Message.replace("Type_", typePicker.getLastTypeName()); //Replaces the word 'Type' by the text at beginType
  }

  void display() {    

    background(bgColor);
    
    image(bigEyeSlides, width/20, height/17, width/10, height/10);
    
    textFont(MainText);
    fill(255);
    rectMode(BASELINE);
    textAlign(CENTER, CENTER);
    //string.BeginMessage();
    textAlign(LEFT);
    text(Message, width/13, height/4, width/2.3, height);
    
    //eye.display();
    //xTime+=0.001;
    //eye.update(new PVector(map(noise(xTime*2),0,1,0,width), map(noise(xTime),0,1,0,height)));

    image(recomClothing, width/4*3, height/2, width/3, height/1.5);
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
