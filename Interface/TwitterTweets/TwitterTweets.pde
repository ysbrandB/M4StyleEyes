
Tweet tweet;
PImage backgroundTweet;
PFont SegoeBold21;
PFont Segoe31;
PFont SegoeSemiBold19;

void setup() {
  size(600, 471);
  imageMode(CENTER);
  backgroundTweet = loadImage("emptyTweet.png");
  SegoeBold21 = createFont("Segoe UI Bold", 21);
  Segoe31 = createFont("Segoe UI", 31);
  SegoeSemiBold19 = createFont("Segoe UI Semibold", 19);
  tweet = new Tweet(backgroundTweet, SegoeBold21, Segoe31, SegoeSemiBold19);
}

void draw() {
  background(255);
  tweet.display();
}

void mousePressed() {
  println(mouseX, mouseY);
}
