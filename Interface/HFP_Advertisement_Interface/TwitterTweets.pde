class Tweet {

  PImage backgroundTweet;

  //all variables for date
  String date;
  String[] maridian = {"AM", "PM"};
  String[] month = {"Jan", "Feb", "Mar", "Apr", "May", "Jun", "Jul", "Aug", "Sep", "Oct", "Nov", "Dec"};

  String likes;
  String retweets;
  String textTweet;

  PImage account;

  String imagePath;

  PFont SegoeBold21;
  PFont Segoe31;
  PFont SegoeSemiBold19;

  Tweet(PImage backgroundTweet, PFont SegoeBold21, PFont Segoe31, PFont SegoeSemiBold19) {
    this.backgroundTweet = backgroundTweet;
    setDate();
    setLikes();
    setTextTweet();

    imagePath = "Image/account.png";
    account = loadImage(imagePath);

    this.SegoeBold21 = SegoeBold21;
    this.Segoe31 = Segoe31;
    this.SegoeSemiBold19 = SegoeSemiBold19;
  }

  void setDate() {
    int randomHour = int(random(1, 13));
    int randomMinute = int(random(60));

    String minutes;
    if (randomMinute < 10) minutes = "0" + randomMinute;
    else minutes = "" + randomMinute;

    String randomMaridian = maridian[int(random(2))];
    String randomMonth = month[int(random(12))];

    int randomDay;
    if (randomMonth == "Apr" || randomMonth == "Jun" || randomMonth == "Sep" || randomMonth == "Nov") {
      randomDay = int(random(1, 31));
    } else if (randomMonth == "Feb") {
      randomDay = int(random(1, 29));
    } else {
      randomDay = int(random(1, 32));
    }

    int randomYear = int(random(2015, 2021));

    date = randomHour + ":" + minutes + " " + randomMaridian + " • " + randomMonth + " " + randomDay + ", " + randomYear;
  }

  void setLikes() {
    likes = nf(random(1, 1000), 0, 1) + "K";

    retweets = nf(random(1, 1000), 0, 1) + "K";
  }

  void setTextTweet() {
    textTweet = "Tesla research has shown that people that wear red polos are more likely to buy electric cars. All tesla staff will start wearing red polos to encourage those people. Wear red polos people!";
  }

  void display(PVector position) {
    pushMatrix();
    translate(position.x, position.y);
    imageMode(CENTER);
    image(backgroundTweet, backgroundTweet.width/2, backgroundTweet.height/2);
    noStroke();    
    fill(0);
    textAlign(RIGHT, TOP);

    //likes
    textFont(SegoeBold21);
    text(likes, 271, 360);

    //retweets
    textFont(SegoeBold21);
    text(retweets, 93, 360);

    textAlign(LEFT, TOP);

    //textTweet  
    textFont(Segoe31);
    textLeading(38);
    text(textTweet, 32, 83, 565, 200);

    //date
    fill(121, 137, 150);
    textAlign(LEFT, TOP);
    textFont(SegoeSemiBold19);
    text(date, 33, 294);

    imageMode(CORNER);
    image(account, 0, 0);
    popMatrix();
  }
}
