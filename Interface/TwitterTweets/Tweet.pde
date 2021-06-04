class Tweet {
  
  PImage backgroundTweet;
  
  Tweet(PImage backgroundTweet) {
    this.backgroundTweet = backgroundTweet;
    
    
  }
  
  void display() {
    image(backgroundTweet, width/2, height/2);
  }
}
