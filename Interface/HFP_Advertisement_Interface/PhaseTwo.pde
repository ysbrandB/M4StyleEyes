class PhaseTwo extends Slide {

  PFont mainText;
  
  PImage tweet;
  
  int favourNumber;
  int opposeNumber;
  
  float favourFactor;

  color recogColor; //the recognizied color from openCV
  color recomColor;  //the recommended color being worn

  String pollDescription;
  String recomClothing;
  String recogClothing;

  PhaseTwo(PFont pTwoMainText) {
    //bgColor = color(0, 255, 0);

    mainText = pTwoMainText;
    
    tweet = loadImage("image/fullelontweet.png");

    favourNumber = 55 + int(random(0, 35));
    opposeNumber = 100 - favourNumber;
    favourFactor = float(favourNumber)/100;
    
    recogColor = color(0, 0, 255);
    recomColor = color(255);
    
    pollDescription = "Official International Institute of Science Poll";
    recomClothing = "Blue Sweater";
    recogClothing = "White Polo";
  }

  void display() {
    background(bgColor);
    
    //println(favourNumber);
    //println(favourFactor);
    
    noStroke();
    fill(recogColor);
    rect(width/8, height/4*3, width/3, height/20);
    fill(recomColor);
    rect(width/8, height/4*3, width/3 * favourFactor, height/20);

    textFont(mainText);

    fill(0);
    text(favourNumber + "%", width/8 + 10, height/4*3+42);
    text(opposeNumber + "%", width/8 + width/4 + 70, height/4*3+42);
    text(pollDescription, width/8-110, height/8*6-50);
    
    image(tweet, width/4*3, height/3);
  }
}
