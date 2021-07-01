class PhaseFour extends Slide {

  //Strings string;
  String encourageMessage;
  String totalRecom;
  PImage bigEyeSlides;
  String[] cheapBrands;
  String[] expensiveBrands;
  color oppositeColor;
  ColorPicker colorPicker;
  TypePicker typePicker;
  HashMap<String, PImage> clothingLookup;
  CommunicationHandler com;
  Eye eye;
  PImage clothes;
  PImage backupShirt;
  float imgAspect;
  Typewriter typeWriterPhase4;

  PhaseFour(CommunicationHandler com, ColorPicker colorPicker, TypePicker typePicker, JSONObject textData, HashMap clothingLookup) {
    bigEyeSlides = loadImage("image/bigEyeSlides.png");
    JSONObject Brands = textData.getJSONObject("Brands"); //Gets all the brands
    JSONArray cheapBrandList=Brands.getJSONArray("Cheap");
    JSONArray expensiveBrandList=Brands.getJSONArray("Expensive");
    cheapBrands = cheapBrandList.getStringArray(); //Splits the brands
    expensiveBrands= expensiveBrandList.getStringArray(); //Splits the brands
    this.colorPicker = colorPicker;
    this.typePicker = typePicker;
    this.clothingLookup= clothingLookup;
    this.com=com;
    eye =new Eye(100, 100, 50);
  }


  void init() {    
    oppositeColor= colorPicker.getLastOppositeColor();
    clothes=clothingLookup.get(colorPicker.getLastOppositeColorName()+"."+typePicker.getLastOppositeTypeName());

    if (clothes==null) {
      println("Couldnt find the picture for: "+ colorPicker.getLastOppositeColorName()+"."+typePicker.getLastOppositeTypeName());
      clothes=backupShirt;
      tint(oppositeColor);
    }

    imgAspect=clothes.height/clothes.width;

    String brandCheap = cheapBrands[int(random(0, cheapBrands.length))]; //Sets 'brandCheap' to one of the stings with the number from bC
    String brandExpensive = expensiveBrands[int(random(0, expensiveBrands.length))]; //Sets 'brandExpensive' to one of the stings with the number from bE

    //Writes a ad with the recommanded color and type 
    encourageMessage = "But DON'T WORRY! You CAN BUY a " + colorPicker.getLastOppositeColorName() + " " + typePicker.getLastOppositeTypeName() + " too!"; 

    //Writes the final message with the "chosen" brands, the new price and the old one.
    totalRecom = "NOW in SALE at:" +" \n" + " \n" +
      brandCheap + ": €" + int(random(10, 40))+".99"+ " (Originally: " + "€"+int(random(40, 100))+ ") \n" + " \n" +
      brandExpensive+ ": €" + int(random(75, 175)) + " (Originally: " + "€"+ int(random(175, 400))+ ")";

    String totalMessage = encourageMessage +" \n"+ totalRecom;
    typeWriterPhase4=new Typewriter(totalMessage, new PVector(width/16, width/8), width/2-width/8, 30, color(255), typePicker.getLastTypeName(), colorPicker.getLastColorName(), colorPicker.getLastColor(), colorPicker.getLastOppositeColorName(), colorPicker.getLastOppositeColor(), typeWriterText);
  }

  void display() {
    fill(0);
    strokeWeight(15);
    stroke(oppositeColor);
    rect(0, 0, width, height);
    eye.display();
    eye.update(com.lookingPositions);
    
    typeWriterPhase4.update();
    typeWriterPhase4.display();

    imageMode(CENTER);
    image(clothes, width/2+width/4, height/2, width/3, (width/3)*imgAspect);
  }
}
