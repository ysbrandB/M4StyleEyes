class PhaseThree extends Slide {

  Tweet tweet;
  PImage backgroundTweet;
  PFont SegoeBold21;
  PFont Segoe31;
  PFont SegoeSemiBold19;
  PFont Oxford;
  PFont Papers;
  PImage NewsHeads;
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

  ColorPicker colorPicker;
  TypePicker typePicker;

  Strings string;

  PhaseThree(ColorPicker colorPicker, TypePicker typePicker) {
    // string = new Strings(colorPicker);
    
    recomClothingImage = loadImage("image/Clothing/White.T-Shirt.png");
    bigEyeSlides = loadImage("image/bigEyeSlides.png");
    
    randomNewsLogo = int(random(1, 5));
    Oxford = createFont("Font/Oxford.ttf", height/30);
    NewsHeads = loadImage("NewsLogos/"+ randomNewsLogo +".png");

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
    string = new Strings(colorPicker);
    com.sendColor(colorPicker.getLastOppositeColor());
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

    image(NewsHeads, 90, 50, 900, 180); //Displays the news logo's
    fill(255);
    textFont(Oxford);
    textLeading(50);
    textAlign(CENTER);
    string.NewsQuote();
    textFont(Papers);
    string.ScientificQuote();
    textAlign(LEFT);
  }
}
