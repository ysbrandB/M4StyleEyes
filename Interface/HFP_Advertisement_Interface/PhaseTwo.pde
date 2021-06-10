class PhaseTwo extends Slide {

  Tweet tweet;
  PImage backgroundTweet;
  PFont SegoeBold21;
  PFont Segoe31;
  PFont SegoeSemiBold19;

  int favorNumber;
  int opposeNumber;

  float favorFactor;

  color recogColor; //the recognized color from openCV
  color recomColor;  //the recommended color being worn

  String pollDescription;
  String recomClothing;
  String recogClothing;

  ColorPicker colorPicker;
  TypePicker typePicker;

  PhaseTwo(ColorPicker colorPicker, TypePicker typePicker) {
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

  void display() {
    background(bgColor);

    //println(favourNumber);
    //println(favourFactor);

    noStroke();
    fill(colorPicker.getLastColor());
    rect(width/8, height/4*3, width/3, height/20);
    fill(colorPicker.getLastOppositeColor());
    rect(width/8, height/4*3, width/3 * favorFactor, height/20);


    textFont(fontHeading);
    fill(colorPicker.getLastOppositeColor());
    text(favorNumber + "%", width/8 + 10, height/4*3+42);
    fill(colorPicker.getLastColor());
    text(opposeNumber + "%", width/8 + width/4 + 70, height/4*3+42);
    fill(0);
    textFont(fontSub);
    text(pollDescription, width/8-110, height/8*6-50);

    tweet.display(new PVector(width*2/3, height/3));    
    //image(tweet, width/4*3, height/3);
  }
}
