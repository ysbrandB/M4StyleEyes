class PhaseTwo extends Slide {
  String Message;
  Eye eye;
  int xTime=0;

  PImage recomClothing;
  PImage bigEyeSlides;
  JSONObject startMsg;
  ColorPicker colorPicker;
  TypePicker typePicker;
   String[] text;
  PhaseTwo(ColorPicker colorPicker, TypePicker typePicker, JSONObject data) {
    eye= new Eye(width/4, height/4, 30);
    this.colorPicker = colorPicker;
    this.typePicker= typePicker;
    bigEyeSlides = loadImage("image/bigEyeSlides.png");
    recomClothing = loadImage("image/Clothing/White.T-Shirt.png");
    
    JSONArray startMsg = data.getJSONArray("startMsg"); //Gets the text for the begin message
    text = startMsg.getStringArray(); //Splits the messages
  }

  void init(CommunicationHandler com) {
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
    textAlign(LEFT);
    text(Message, width/13, height/4, width/2.3, height);
    image(recomClothing, width/4*3, height/2, width/3, height/1.5);
  }
}
