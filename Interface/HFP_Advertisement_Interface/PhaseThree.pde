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
  Eye eye;
  float imgAspect;
  String Quote;
  String Fact;

  String[] NewsQuote; //String for all the newsmessages
  String[] ScientificFact; //String for all the scientific papar quotes
  String[] tweets; //String for all the scientific papar quotes
  ColorPicker colorPicker;
  TypePicker typePicker;

  PhaseThree(ColorPicker colorPicker, TypePicker typePicker, JSONObject textData, HashMap clothingLookup) {
    this.clothingLookup=clothingLookup;
    backupShirt=loadImage(sketchPath()+"\\Image\\backUpShirt.jpg");

    JSONArray NewsHeads = textData.getJSONArray("NewsHeads"); //Gets the text for the news quotes
    JSONArray ScientificFacts = textData.getJSONArray("ScientificFacts"); //Gets the scientific quotes
    JSONArray TwitterTweets = textData.getJSONArray("Tweets"); //Gets the scientific quotes

    NewsQuote = NewsHeads.getStringArray(); //Splits the quotes
    ScientificFact = ScientificFacts.getStringArray(); //Splits the quotes
    tweets=TwitterTweets.getStringArray(); //Splits the quotes
    this.colorPicker = colorPicker;
    this.typePicker = typePicker;
    eye =new Eye(100, 100, 50);
    backgroundTweet = loadImage("Image/emptyTweet.png");
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

    Quote = NewsQuote[int(random(0, NewsQuote.length))]; //Sets 'Quote' to one of the stings with the number from n
    Quote = Quote.replace("Color_", colorPicker.getLastOppositeColorName()); //Replaces the word 'Color_' by the text at beginColor
    Quote = Quote.replace("Type_", typePicker.getLastOppositeTypeName()); //Replaces the word 'Type' by the text at beginType

    Fact = ScientificFact[int(random(0, ScientificFact.length))]; //Sets 'Fact' to one of the stings with the number from f
    Fact = Fact.replace("Color_", colorPicker.getLastOppositeColorName()); //Replaces the word 'Color_' by the text at beginColor
    Fact = Fact.replace("ColorQ_", colorPicker.getLastColorName()); //Replaces the word 'Color_' by the text at beginColor
    Fact = Fact.replace("Type_", typePicker.getLastOppositeTypeName()); //Replaces the word 'Type' by the text at beginType

    typeWriter=new Typewriter(Fact, new PVector(width/16, width/8), width/2-width/8, 40, color(255), "DIT MAAKT NIET UIT", "DIT MAAKT OOK NIET UIT", clothingColor, colorPicker.getLastOppositeColorName(), oppositeColor, fontSub);
    poll = new Poll(new PVector(width/2, height/2), width/3, width/6, fontSub, clothingColor, oppositeColor);
    
    String tweetMessage=tweets[int(random(tweets.length))];
    tweetMessage=tweetMessage.replace("Color_", colorPicker.getLastOppositeColorName().toLowerCase()); //Replaces the word 'Color_' by the text at beginColor
    tweetMessage=tweetMessage.replace("Type_", typePicker.getLastOppositeTypeName().toLowerCase()); //Replaces the word 'Type' by the text at beginType
    tweet = new Tweet(new PVector(width/16, height/2), backgroundTweet, SegoeBold21, Segoe31, SegoeSemiBold19, tweetMessage);
  }

  void display() {
    background(bgColor);
    fill(0);
    strokeWeight(15);
    stroke(oppositeColor);
    rect(0, 0, width, height);
    eye.display();
    typeWriter.update();
    typeWriter.display();
    poll.display();
    tweet.display();
    imageMode(CENTER);
    image(clothes, width/2+width/8, height/2-height/4, width/4, (width/4)*imgAspect);
  }
}
