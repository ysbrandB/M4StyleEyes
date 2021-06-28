class Poll {
  PVector position;
  PFont font;

  color clothingColor, oppositeColor;

  float myWidth, myHeight;
  float fillPollClothingColor = 0;
  float fillPollOppositeColor = 0;
  float likePercentage;
  float disLikePercentage;
  
  Poll(PVector position, float myWidth, float myHeight, PFont font, color clothingColor, color oppositeColor) {
    this.position = position;
    this.font = font;
    this.clothingColor = clothingColor;
    this.oppositeColor = oppositeColor;
    this.myWidth = myWidth;
    this.myHeight = myHeight;
    likePercentage = float(nf(random(60, 82), 0, 2));
    disLikePercentage = float(nf(100 - likePercentage, 0, 2));
  }

  void display() {
    pushMatrix();
    translate(position.x, position.y);
    textFont(font);


    fill(255);
    textSize(myWidth/10);
    textAlign(LEFT, TOP);
    text("Which color fits better?", myWidth/32, 0);
    

    noStroke();   
    textSize(myWidth/20);
    textAlign(RIGHT, CENTER);

    fill(oppositeColor);
    fillPollOppositeColor += 2;
    if(fillPollOppositeColor >= myWidth*likePercentage/100) fillPollOppositeColor = myWidth*likePercentage/100;
    rect(myWidth/32, myHeight/5, fillPollOppositeColor, myHeight/4, myHeight/32, 0, 0, myHeight/32);
    fill(255);
    text(likePercentage + "%", myWidth, myHeight/5 + myHeight/8);
    
    fill(clothingColor);
    fillPollClothingColor += 2;
    if(fillPollClothingColor >= myWidth*disLikePercentage/100) fillPollClothingColor = myWidth*disLikePercentage/100;
    rect(myWidth/32, myHeight/2, fillPollClothingColor, myHeight/4, myHeight/32, 0, 0, myHeight/32);
    fill(255);
    text(disLikePercentage + "%", myWidth, myHeight/2 + myHeight/8);
    

    stroke(255);
    strokeWeight(2);
    noFill();
    rect(myWidth/32, myHeight/5, myWidth, myHeight/4, myHeight/32, myHeight/32, myHeight/32, myHeight/32);
    rect(myWidth/32, myHeight/2, myWidth, myHeight/4, myHeight/32, myHeight/32, myHeight/32, myHeight/32);
    
    popMatrix();
  }
}
