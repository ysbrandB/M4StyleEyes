class PhaseTwo extends Slide {
  String Message;
  Eye eye;
  int xTime=0;

  PImage clothes;
  PImage bigEyeSlides;
  JSONObject startMsg;
  String loadImage;
  ColorPicker colorPicker;
  TypePicker typePicker;
  HashMap<String, PImage> clothingLookup;
  PImage backupShirt;
  int imgAspect;
  String[] text;

  PhaseTwo(ColorPicker colorPicker, TypePicker typePicker, JSONObject data, HashMap clothingLookup) {
    this.clothingLookup=clothingLookup;
    eye= new Eye(width/4, height/4, 30);
    this.colorPicker = colorPicker;
    this.typePicker= typePicker;    

    JSONArray startMsg = data.getJSONArray("startMsg"); //Gets the text for the begin message
    text = startMsg.getStringArray(); //Splits the messages
    backupShirt=loadImage(sketchPath()+"\\Image\\backUpShirt.jpg");
  }

  void init(CommunicationHandler com) {
    com.sendColor(colorPicker.getLastColor());

    clothes=clothingLookup.get(colorPicker.getLastColorName()+"."+typePicker.getLastTypeName());

    if (clothes==null) {
      println("Couldnt find the picture for: "+colorPicker.getLastColorName()+"."+typePicker.getLastTypeName());
      clothes=backupShirt;
      tint(colorPicker.getLastOppositeColor());
    }
    imgAspect=clothes.height/clothes.width;

    Message = text[int(random(0, text.length))]; //Sets 'Message' to one of the strings with the number from s
    Message = Message.replace("ColorQ_", colorPicker.getLastColorName()); //Replaces the word 'Color_' by the text at beginColor
    Message = Message.replace("Type_", typePicker.getLastTypeName()); //Replaces the word 'Type' by the text at beginType
  }

  void display() {    

    background(bgColor);

    textFont(MainText);
    fill(255);
    rectMode(BASELINE);
    textAlign(CENTER, CENTER);
    textAlign(LEFT);
    text(Message, width/13, height/4, width/2.3, height);
    image(clothes, width/4*3, height/2, width/3, height/1.5);
  }
}
