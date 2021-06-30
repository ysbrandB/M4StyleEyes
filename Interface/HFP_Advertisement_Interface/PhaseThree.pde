class PhaseThree extends Slide {
  HashMap<String, PImage> clothingLookup;
  color clothingColor;
  color oppositeColor;
  Tweet tweet;
  Poll poll;
  Typewriter typeWriter;
  PImage backgroundTweet;
  PImage clothes;
  PImage backupShirt;
  float imgAspect;
  Eye eye;
  String Quote;
  String Fact;

  String[] NewsQuote; //String for all the newsmessages
  String[] ScientificFact; //String for all the scientific papar quotes
  JSONArray tweetObjects;
  // String[] tweets; //String for all the scientific papar quotes
  ColorPicker colorPicker;
  TypePicker typePicker;
  CommunicationHandler com;

  HashMap<String, PImage> tweetImgLookup;

  PhaseThree(CommunicationHandler com, ColorPicker colorPicker, TypePicker typePicker, JSONObject textData, HashMap clothingLookup, HashMap tweetImgLookup) {
    this.clothingLookup=clothingLookup;
    backupShirt=loadImage(sketchPath()+"\\Image\\backUpShirt.jpg");
    this.com=com;
   // JSONArray NewsHeads = textData.getJSONArray("NewsHeads"); //Gets the text for the news quotes
    JSONArray ScientificFacts = textData.getJSONArray("Feitjes"); //Gets the scientific quotes
    tweetObjects = textData.getJSONArray("Tweets"); //Gets the scientific quotes

    //NewsQuote = NewsHeads.getStringArray(); //Splits the quotes
    ScientificFact = ScientificFacts.getStringArray(); //Splits the quotes
    // tweets=TwitterTweets.getStringArray(); //Splits the quotes
    this.colorPicker = colorPicker;
    this.typePicker = typePicker;
    eye =new Eye(100, 100, 50);
    backgroundTweet = loadImage("Image/emptyTweet.png");

    this.tweetImgLookup =tweetImgLookup;
  }

  void init(CommunicationHandler com) {
    clothingColor= colorPicker.getLastColor();
    oppositeColor= colorPicker.getLastOppositeColor();

    com.sendColor(oppositeColor);

    clothes=clothingLookup.get(colorPicker.getLastOppositeColorName()+"."+typePicker.getLastOppositeTypeName());

    if (clothes==null) {
      println("Couldnt find the picture for: "+ colorPicker.getLastOppositeColorName()+"."+typePicker.getLastOppositeTypeName());
      clothes=backupShirt;
      tint(oppositeColor);
    }
    imgAspect=clothes.height/clothes.width;

    //Quote = NewsQuote[int(random(0, NewsQuote.length))]; //Sets 'Quote' to one of the stings with the number from n
    //Quote = Quote.replace("Color_", colorPicker.getLastOppositeColorName()); //Replaces the word 'Color_' by the text at beginColor
    //Quote = Quote.replace("Type_", typePicker.getLastOppositeTypeName()); //Replaces the word 'Type' by the text at beginType

    Fact = ScientificFact[int(random(0, ScientificFact.length))]; //Sets 'Fact' to one of the stings with the number from f
    Fact = Fact.replace("Color_", colorPicker.getLastOppositeColorName()); //Replaces the word 'Color_' by the text at beginColor
    Fact = Fact.replace("ColorQ_", colorPicker.getLastColorName()); //Replaces the word 'Color_' by the text at beginColor
    Fact = Fact.replace("Type_", typePicker.getLastOppositeTypeName()); //Replaces the word 'Type' by the text at beginType

    typeWriter=new Typewriter(Fact, new PVector(width/16, width/8), width/2-width/8, 40, color(255), "DIT MAAKT NIET UIT", "DIT MAAKT OOK NIET UIT", clothingColor, colorPicker.getLastOppositeColorName(), oppositeColor, fontSub);
    poll = new Poll(new PVector(width/2, height/2), width/3, width/6, fontSub, clothingColor, oppositeColor);
    
    JSONObject tweetObj = tweetObjects.getJSONObject(int(random(tweetObjects.size())));
    String tweetMessage = tweetObj.getString("text");
    tweetMessage=tweetMessage.replace("Color_", colorPicker.getLastOppositeColorName().toLowerCase()); //Replaces the word 'Color_' by the text at beginColor
    tweetMessage=tweetMessage.replace("Type_", typePicker.getLastOppositeTypeName().toLowerCase()); //Replaces the word 'Type' by the text at beginType
    // println(tweetObj.getString("name"));
    println(tweetImgLookup.values());
    tweet = new Tweet(new PVector(width/16, height/2), backgroundTweet, SegoeBold21, Segoe31, SegoeSemiBold19, tweetMessage, (PImage) tweetImgLookup.get(tweetObj.getString("name")));
  }

  void display() {
    fill(0);
    strokeWeight(15);
    stroke(oppositeColor);
    rect(0, 0, width, height);
    eye.display();
    eye.update(com.lookingPositions);
    typeWriter.update();
    typeWriter.display();
    poll.display();
    tweet.display();
    imageMode(CENTER);
    image(clothes, width/2+width/8, height/2-height/4, width/4, (width/4)*imgAspect);
  }
}
