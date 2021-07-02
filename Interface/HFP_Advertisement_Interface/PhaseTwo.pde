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
  Typewriter typeWriterPhase2;
  CommunicationHandler com;
  PhaseTwo(CommunicationHandler com,ColorPicker colorPicker, TypePicker typePicker, JSONObject data, HashMap clothingLookup) {
    this.clothingLookup=clothingLookup;
    this.com=com;
    eye=new Eye(100, 100, 50);
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
  
    typeWriterPhase2=new Typewriter(Message, new PVector(width/16, width/8), width/2-width/8, 30, color(255), typePicker.getLastTypeName(), colorPicker.getLastColorName(), colorPicker.getLastColor(), colorPicker.getLastOppositeColorName(), colorPicker.getLastOppositeColor(), typeWriterText);

  }

  void display() {    
    background(bgColor);
    fill(0);
    strokeWeight(15);
    stroke(colorPicker.getLastColor());
    rect(0, 0, width, height);
    fill(255);
    rectMode(BASELINE);
    typeWriterPhase2.update();
    typeWriterPhase2.display();
    image(clothes, width/4*3, height/2, width/3, height/1.5);
    eye.display();
    eye.update(com.lookingPositions);
  }
}
