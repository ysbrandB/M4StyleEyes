class Strings {
  JSONObject json;
  JSONArray startMsg, NewsHeads, ScientificFacts, Brands;

  int s, n, f, bC, bE; 
  int chpRandomPrice;  //random number generated to calculate all cheap prices
  int expRandomPrice; //random number generated to calculate all expensive prices
  
  int orgCheapPrice; //number for the original cheap brand price
  int orgExpensivePrice; //number for the original expensive brand price

  String[] text;
  String[] NewsQuote;
  String[] ScientificFact;
  String[] Brand;

  String Message;
  String Quote;
  String Fact;
  String BrandCheap;
  String BrandExpensive;

  String encourageMessage; //encourages the person the buy the product
  String totalRecom; //total message
  String cheapBrand; //the randomly selected cheap brand
  String expensiveBrand; //the randomly selected expensive brand
  String chpBrandPrice; //randomly generated cheap brand price
  String expBrandPrice; //randomly generated expensive brand price
  String chpOriginalPrice; //randomly generated original expensive brand price
  String expOrignialPrice; //randomly generated original expensive brand price

  String BeginColor = "red";
  String NewColor = "Blue";
  String BeginType = "T-Shirt";
  String NewType = "Sweater";

  Strings() {
    s = int(random(0, 5));
    n = int(random(0, 7));
    f = int(random(0, 1));
    bC = int(random(0, 3));
    bE = int(random(3, 6));

    json = loadJSONObject("JsonFiles/Text.JSON");
    startMsg = json.getJSONArray("startMsg");
    NewsHeads = json.getJSONArray("NewsHeads");
    ScientificFacts = json.getJSONArray("ScientificFacts");
    Brands = json.getJSONArray("Brands");

    text = startMsg.getStringArray();
    NewsQuote = NewsHeads.getStringArray();
    ScientificFact = ScientificFacts.getStringArray();
    Brand = Brands.getStringArray();

    Message = text[s];
    Message = Message.replace("Color_", BeginColor);
    Message = Message.replace("Type_", BeginType);
    
    Quote = NewsQuote[n];
    Quote = Quote.replace("Color_", NewColor);
    Quote = Quote.replace("Type_", NewType);

    Fact = ScientificFact[f];
    Fact = Fact.replace("Color_", NewColor);
    Fact = Fact.replace("Type_", NewType);

    BrandCheap = Brand[bC];
    BrandExpensive = Brand[bE];

    encourageMessage = "But DON'T WORRY! You CAN" + "\n"+ "BUY a " + NewColor + " " + NewType + " too!"; 

    chpRandomPrice = int(random(1, 5));
    expRandomPrice = int(random(10, 20));

    chpBrandPrice = chpRandomPrice + "9";
    expBrandPrice =  expRandomPrice + "9";
    
    orgCheapPrice = chpRandomPrice + 1;
    orgExpensivePrice = expRandomPrice + 5;;
    
    chpOriginalPrice = orgCheapPrice + "9";
    expOrignialPrice = orgExpensivePrice + "9";

    totalRecom = "NOW in SALE at" +"\n" + 
      BrandCheap + ": " + chpBrandPrice + "€"+ "  <-  Originally: " + (chpOriginalPrice) + "€" +"\n" + 
      BrandExpensive + ": " + expBrandPrice + "€"+ "  <-  Originally: " + (expOrignialPrice) + "€";
  }

  void BeginMessage() {
    text(Message,width/9, height/8, width/2-100, height);
  }
  void NewsQuote() {
    text(Quote, width/9, height/4, width/2-100, height/2); 
  }
  void ScientificQuote() {
    text(Fact,width/2+200, height*3/4, width, height);
  }
  void Brands() {
    text(encourageMessage, width/8, height/4);
    text(totalRecom, width/8, height/3*2);
  }
}
