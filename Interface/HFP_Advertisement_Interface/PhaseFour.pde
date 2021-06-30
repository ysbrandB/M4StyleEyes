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
  Eye eye;
  PImage clothes;
  PImage backupShirt;
  float imgAspect;

  PhaseFour(ColorPicker colorPicker, TypePicker typePicker, JSONObject textData, HashMap clothingLookup) {
    bigEyeSlides = loadImage("image/bigEyeSlides.png");
    JSONObject Brands = textData.getJSONObject("Brands"); //Gets all the brands
    JSONArray cheapBrandList=Brands.getJSONArray("Cheap");
    JSONArray expensiveBrandList=Brands.getJSONArray("Expensive");
    cheapBrands = cheapBrandList.getStringArray(); //Splits the brands
    expensiveBrands= expensiveBrandList.getStringArray(); //Splits the brands
    this.colorPicker = colorPicker;
    this.typePicker = typePicker;
    this.clothingLookup= clothingLookup;
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

    String BrandCheap = cheapBrands[int(random(0, cheapBrands.length))]; //Sets 'BrandCheap' to one of the stings with the number from bC
    String BrandExpensive = expensiveBrands[int(random(0, expensiveBrands.length))]; //Sets 'BrandExpensive' to one of the stings with the number from bE

    //Writes a ad with the recommanded color and type 
    encourageMessage = "But DON'T WORRY! You CAN" + "\n"+ "BUY a " + colorPicker.getLastOppositeColorName() + " " + typePicker.getLastOppositeTypeName() + " too!"; 

    //Writes the final message with the "chosen" brands, the new price and the old one.
    totalRecom = "NOW in SALE at" +"\n" + 
      BrandCheap + ": €" + int(random(10, 40))+".99"+ "  <-  Originally: " + "€"+int(random(40, 100)) +"\n"+
      BrandExpensive+ ": " + int(random(75, 175)) + "€"+ "  <-  Originally: " + "€"+ int(random(175, 400));
  }

  void display() {
    fill(0);
    strokeWeight(15);
    stroke(oppositeColor);
    rect(0, 0, width, height);
    eye.display();

    textFont(fontHeading);
    fill(255);
    textAlign(TOP, LEFT);
    text(encourageMessage, width/8, height/4-100);
    text(totalRecom, width/8, height/2);
    imageMode(CENTER);
    image(clothes, width/2+width/4, height/2, width/3, (width/3)*imgAspect);
  }
}
