class Strings {
  JSONObject json;
  JSONArray startMsg, NewsHeads, ScientificFacts, Brands;

  int s, n, f, bC, bE; //Intergers for randomness out of the database
  int chpRandomPrice;  //random number generated to calculate all cheap prices
  int expRandomPrice; //random number generated to calculate all expensive prices
  
  int orgCheapPrice; //number for the original cheap brand price
  int orgExpensivePrice; //number for the original expensive brand price

  String[] text; //String for all the beginmessages
  String[] NewsQuote; //String for all the newsmessages
  String[] ScientificFact; //String for all the scientific papar quotes
  String[] Brand; //String for all the different types of brands

  String Message; //The printed text
  String Quote; //The printed text
  String Fact; //The printed text
  String BrandCheap; //The printed text
  String BrandExpensive; //The printed text

  String encourageMessage; //encourages the person the buy the product
  String totalRecom; //total message
  String cheapBrand; //the randomly selected cheap brand
  String expensiveBrand; //the randomly selected expensive brand
  String chpBrandPrice; //randomly generated cheap brand price
  String expBrandPrice; //randomly generated expensive brand price
  String chpOriginalPrice; //randomly generated original expensive brand price
  String expOrignialPrice; //randomly generated original expensive brand price

  String BeginColor = "red"; //Placeholder recognized color
  String NewColor = "Blue"; //Placeholder recommanded color
  String BeginType = "T-Shirt"; //Placeholder recognized type
  String NewType = "Sweater"; //Placeholder recommended type

  Strings() {
    s = int(random(0, 9)); //Chooses any random number for the string
    n = int(random(0, 7)); //Chooses any random number for the string
    f = int(random(0, 3)); //Chooses any random number for the string
    bC = int(random(0, 3)); //Chooses any random number for the string
    bE = int(random(3, 9)); //Chooses any random number for the string

    json = loadJSONObject("JsonFiles/Text.JSON"); //Gets the json file
    startMsg = json.getJSONArray("startMsg"); //Gets the text for the begin message
    NewsHeads = json.getJSONArray("NewsHeads"); //Gets the text for the news quotes
    ScientificFacts = json.getJSONArray("ScientificFacts"); //Gets the scientific quotes
    Brands = json.getJSONArray("Brands"); //Gets all the brands

    text = startMsg.getStringArray(); //Splits the messages
    NewsQuote = NewsHeads.getStringArray(); //Splits the quotes
    ScientificFact = ScientificFacts.getStringArray(); //Splits the quotes
    Brand = Brands.getStringArray(); //Splits the brands

    Message = text[s]; //Sets 'Message' to one of the stings with the number from s
    Message = Message.replace("ColorQ_", BeginColor); //Replaces the word 'Color_' by the text at beginColor
    Message = Message.replace("Type_", BeginType); //Replaces the word 'Type' by the text at beginType
    
    Quote = NewsQuote[n]; //Sets 'Quote' to one of the stings with the number from n
    Quote = Quote.replace("Color_", NewColor); //Replaces the word 'Color_' by the text at beginColor
    Quote = Quote.replace("Type_", NewType); //Replaces the word 'Type' by the text at beginType

    Fact = ScientificFact[f]; //Sets 'Fact' to one of the stings with the number from f
    Fact = Fact.replace("Color_", NewColor); //Replaces the word 'Color_' by the text at beginColor
    Fact = Fact.replace("ColorQ_", BeginColor); //Replaces the word 'Color_' by the text at beginColor
    Fact = Fact.replace("Type_", NewType); //Replaces the word 'Type' by the text at beginType

    BrandCheap = Brand[bC]; //Sets 'BrandCheap' to one of the stings with the number from bC
    BrandExpensive = Brand[bE]; //Sets 'BrandExpensive' to one of the stings with the number from bE

    //Writes a ad with the recommanded color and type 
    encourageMessage = "But DON'T WORRY! You CAN" + "\n"+ "BUY a " + NewColor + " " + NewType + " too!"; 

    chpRandomPrice = int(random(1, 5));
    expRandomPrice = int(random(10, 20));

    chpBrandPrice = chpRandomPrice + "9";
    expBrandPrice =  expRandomPrice + "9";
    
    orgCheapPrice = chpRandomPrice + 1;
    orgExpensivePrice = expRandomPrice + 5;;
    
    chpOriginalPrice = orgCheapPrice + "9";
    expOrignialPrice = orgExpensivePrice + "9";

    //Writes the final message with the "chosen" brands, the new price and the old one.
    totalRecom = "NOW in SALE at" +"\n" + 
      BrandCheap + ": " + chpBrandPrice + "€"+ "  <-  Originally: " + (chpOriginalPrice) + "€" +"\n" + 
      BrandExpensive + ": " + expBrandPrice + "€"+ "  <-  Originally: " + (expOrignialPrice) + "€";
  }

  void BeginMessage() {
    text(Message,width/9, height/5, width/2-100, height);
  }

  void NewsQuote() {
    text(Quote, width/9, height/4, width/2-100, height/2); 
  }

  void ScientificQuote() {
    text(Fact,width/2+150, height/2+150, width/2-200, height);
  }

  void Brands() {
    text(encourageMessage, width/8, height/4-100);
    text(totalRecom, width/8, height/2);
  }
}
