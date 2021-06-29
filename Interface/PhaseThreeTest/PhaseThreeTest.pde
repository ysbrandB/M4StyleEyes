color clothingColor=color(200,0,200);
color oppositeColor=color(255,255,0);
Typewriter typeWriter;
String Fact="BULLSHIT OVER DAT JE HIERDOOR ECHT 100% beter wordt van Color_ want fuck it science bitch!";
PFont Oxford;
Poll poll;
Tweet tweet;

void setup(){
    size(1920,1080);
    typeWriter=new Typewriter(Fact, new PVector(width/16,width/8), width/2-width/8, 40, color(255), "Polos", "Yellow", clothingColor, "Purple", oppositeColor);
    Oxford = createFont("../HFP_Advertisement_Interface/Font/Oxford.ttf", height/30);
    poll = new Poll(new PVector(width/2, height/2), width/3, width/6, Oxford, clothingColor, oppositeColor);

    PImage backgroundTweet = loadImage("../HFP_Advertisement_Interface/Image/emptyTweet.png");
    PFont SegoeBold21 = createFont("Segoe UI Bold", 21);
    PFont Segoe31 = createFont("Segoe UI", 31);
    PFont SegoeSemiBold19 = createFont("Segoe UI Semibold", 19);
    tweet = new Tweet(new PVector(width/16, height/2), backgroundTweet, SegoeBold21, Segoe31, SegoeSemiBold19);
}

void draw(){
    background(0);
    fill(0);
    strokeWeight(15);
    stroke(oppositeColor);
    rect(0,0,width, height);
    typeWriter.update();
    typeWriter.display();
    poll.display();
    tweet.display();
}