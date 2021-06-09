
Tweet tweet;
PImage backgroundTweet;

void setup() {
  size(600, 471);
  imageMode(CENTER);
  backgroundTweet = loadImage("tweet.png");
  tweet = new Tweet(backgroundTweet);
}

void draw() {
  background(255);
  tweet.display();
}

void mousePressed() {
  println(mouseX, mouseY);
}
