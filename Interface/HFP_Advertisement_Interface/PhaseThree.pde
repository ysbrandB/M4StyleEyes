class PhaseThree extends Slide {

  Tweet tweet;
  PImage backgroundTweet;
  PFont SegoeBold21;
  PFont Segoe31;
  PFont SegoeSemiBold19;
  PFont Oxford;
  PFont Papers;
  PImage NewsHeadsPicture;
  PImage recomClothingImage; 
  PImage bigEyeSlides;

  int favorNumber;
  int opposeNumber;
  int randomNewsLogo;

  float favorFactor;

  color recogColor; //the recognized color from openCV
  color recomColor;  //the recommended color being worn

  String pollDescription;
  String recomClothing;
  String recogClothing;
  
  String Quote;
  String Fact;
  
  String[] NewsQuote; //String for all the newsmessages
  String[] ScientificFact; //String for all the scientific papar quotes

  ColorPicker colorPicker;
  TypePicker typePicker;

  //Strings string;

  PhaseThree(ColorPicker colorPicker, TypePicker typePicker, JSONObject textData) {
    JSONArray NewsHeads = textData.getJSONArray("NewsHeads"); //Gets the text for the news quotes
    JSONArray ScientificFacts = textData.getJSONArray("ScientificFacts"); //Gets the scientific quotes
    
    NewsQuote = NewsHeads.getStringArray(); //Splits the quotes
    ScientificFact = ScientificFacts.getStringArray(); //Splits the quotes
    
    recomClothingImage = loadImage("image/Clothing/White.T-Shirt.png");
    bigEyeSlides = loadImage("image/bigEyeSlides.png");
    
    Oxford = createFont("Font/Oxford.ttf", height/30);
    NewsHeadsPicture = loadImage("NewsLogos/"+ int(random(1, 5)) +".png");

    Papers = createFont("Font/Paper.otf", 30);

    backgroundTweet = loadImage("Image/emptyTweet.png");
    SegoeBold21 = createFont("Segoe UI Bold", 21);
    Segoe31 = createFont("Segoe UI", 31);
    SegoeSemiBold19 = createFont("Segoe UI Semibold", 19);
    tweet = new Tweet(backgroundTweet, SegoeBold21, Segoe31, SegoeSemiBold19);

    favorNumber = 55 + int(random(0, 35));
    opposeNumber = 100 - favorNumber;
    favorFactor = float(favorNumber)/100;

    recogColor = colorPicker.getLastColor();
    recomColor = colorPicker.getLastOppositeColor();

    pollDescription = "Official International Institute of Science Poll";
    recomClothing = "Blue Sweater";
    recogClothing = "White Polo";

    this.colorPicker = colorPicker;
    this.typePicker = typePicker;
  }

  void init(CommunicationHandler com) {
    //string = new Strings(colorPicker);
    com.sendColor(colorPicker.getLastOppositeColor());
    
    Quote = NewsQuote[int(random(0,NewsQuote.length))]; //Sets 'Quote' to one of the stings with the number from n
    Quote = Quote.replace("Color_", colorPicker.getLastOppositeColorName()); //Replaces the word 'Color_' by the text at beginColor
    Quote = Quote.replace("Type_", typePicker.getLastOppositeTypeName()); //Replaces the word 'Type' by the text at beginType

    Fact = ScientificFact[int(random(0,ScientificFact.length))]; //Sets 'Fact' to one of the stings with the number from f
    Fact = Fact.replace("Color_", colorPicker.getLastOppositeColorName()); //Replaces the word 'Color_' by the text at beginColor
    Fact = Fact.replace("ColorQ_", colorPicker.getLastColorName()); //Replaces the word 'Color_' by the text at beginColor
    Fact = Fact.replace("Type_",  typePicker.getLastOppositeTypeName()); //Replaces the word 'Type' by the text at beginType
  }

  void display() {
    background(bgColor);
    
    image(bigEyeSlides, width/20+3, height/17+3, width/10, height/10);
    
    strokeWeight(3);
    if (colorPicker.getLastColor() == color(0,0,0)) {
      stroke(255);
    } else {
      stroke(colorPicker.getLastColor());
    }
    noFill();
    rect(0, 0, 0.58*width, 0.5*height);
    rect(0, 0.5*height, 0.58*width, height);
    rect(0.58*width, 0, width-2, 0.7*height);
    rect(0.58*width, 0.7*height, width, height);
    
    image(recomClothingImage, 0.79*width, height/2.9, 0.35*width, 0.67*height);
    
    strokeWeight(0.5);
    stroke(colorPicker.getLastOppositeColor());
    fill(colorPicker.getLastColor());
    rect(width/8, height/4*3+75, width/3, height/20);
    fill(colorPicker.getLastOppositeColor());
    rect(width/8, height/4*3+75, width/3 * favorFactor, height/20);

    textFont(fontHeading);
    fill(colorPicker.getLastOppositeColor());
    text(favorNumber + "%", width/8 + 10, height/4*3+42);
    if (colorPicker.getLastColor() == color(0,0,0)) {
      fill(255);
    } else {
      fill(colorPicker.getLastColor());
    }
    text(opposeNumber + "%", width/8 + width/4 + 70, height/4*3+42);
    fill(255);
    textFont(fontSub);
    text(pollDescription, width/7.9, height/8*6.3);

    //tweet.display(new PVector(width*2/3-50, height/12-20));    

    image(NewsHeadsPicture, 90, 50, 900, 180); //Displays the news logo's
    fill(255);
    textFont(Oxford);
    textLeading(50);
    textAlign(CENTER);
    text(Quote, width/10-50, height/4+75, width/2-100, height/2);
    textFont(Papers);
    text(Fact, width/2+150, height/2+150, width/4, height);
    textAlign(LEFT);
  }
}
