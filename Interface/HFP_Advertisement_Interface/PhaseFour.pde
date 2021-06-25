class PhaseFour extends Slide {

  //Strings string;
  String encourageMessage;
  String totalRecom;
  PImage bigEyeSlides;
  String[] Brand;
  String BrandCheap;
  String BrandExpensive;

  PhaseFour(JSONObject textData) {
    bigEyeSlides = loadImage("image/bigEyeSlides.png");
    JSONArray Brands = textData.getJSONArray("Brands"); //Gets all the brands
     Brand = Brands.getStringArray(); //Splits the brands
  }


  void init() {    
    BrandCheap = Brand[int(random(0,Brand.length))]; //Sets 'BrandCheap' to one of the stings with the number from bC
    BrandExpensive = Brand[int(random(0,Brand.length))]; //Sets 'BrandExpensive' to one of the stings with the number from bE
    
    //Writes a ad with the recommanded color and type 
    encourageMessage = "But DON'T WORRY! You CAN" + "\n"+ "BUY a " + colorPicker.getLastOppositeColorName() + " " + typePicker.getLastOppositeTypeName() + " too!"; 

    //Writes the final message with the "chosen" brands, the new price and the old one.
    totalRecom = "NOW in SALE at" +"\n" + 
      BrandCheap + ": €" + int(random(10,40))+".99"+ "  <-  Originally: " + "€"+int(random(40,100)) +"\n"+
      BrandExpensive+ ": " + int(random(75,175)) + "€"+ "  <-  Originally: " + "€"+ int(random(175,400));
  }

  void display() {
    background(bgColor);
    image(bigEyeSlides, width/20+3, height/17+3, width/10, height/10);

    textFont(fontHeading);
    fill(255);
    textAlign(TOP, LEFT);
    text(encourageMessage, width/8, height/4-100);
    text(totalRecom, width/8, height/2);
  }
}
