
class Tweet {

  PImage backgroundTweet;

  //all variables for date
  String date;
  int randomHour;
  int randomMinute;
  String minutes;
  String randomMaridian;
  String[] maridian = {"AM", "PM"};
  String randomMonth;
  String[] month = {"Jan", "Feb", "Mar", "Apr", "May", "Jun", "Jul", "Aug", "Sep", "Oct", "Nov", "Dec"};
  int randomDay;
  int randomYear;

  String likes;
  String retweets;
  String textTweet;

  Tweet(PImage backgroundTweet) {
    this.backgroundTweet = backgroundTweet;
    setDate();
    setLikes();
    setTextTweet();
  }

  void setDate() {
    date = "8:19 PM • Feb 2, 2021";
    randomHour = int(random(1, 13));
    randomMinute = int(random(60));

    if (randomMinute < 10) minutes = "0" + randomMinute;
    else minutes = "" + randomMinute;

    randomMaridian = maridian[int(random(2))];
    randomMonth = month[int(random(12))];

    if (randomMonth == "Apr" || randomMonth == "Jun" || randomMonth == "Sep" || randomMonth == "Nov") {
      randomDay = int(random(1, 31));
    } else if (randomMonth == "Feb") {
      randomDay = int(random(1, 29));
    } else {
      randomDay = int(random(1, 32));
    }

    randomYear = int(random(2010, 2021));
    date = randomHour + ":" + minutes + " " + randomMaridian + " • " + randomMonth + " " + randomDay + ", " + randomYear;
  }

  void setLikes() {
    likes = nf(random(1, 1000), 0, 1) + "K";

    retweets = nf(random(1, 1000), 0, 1) + "K";
  }

  void setTextTweet() {
    textTweet = "Tesla research has shown that people that wear red polos are more likely to buy electric cars. All tesla staff will start wearing red polos to encourage those people. Wear red polos peaople!";
  }

  void display() {
    image(backgroundTweet, width/2, height/2);
    noStroke();

    //date
    fill(255);
    rect(30, 295, 205, 25);

    fill(121, 137, 150);
    textAlign(LEFT, TOP);
    textFont(createFont("Segoe UI Semibold", 19));
    text(date, 33, 294);

    //likes
    fill(255);
    rect(210, 365, 65, 20);

    fill(0);
    textAlign(RIGHT, TOP);
    textFont(createFont("Segoe UI Bold", 21));
    text(likes, 271, 360);

    //retweets
    fill(255);
    rect(33, 365, 65, 20);

    fill(0);
    textAlign(RIGHT, TOP);
    textFont(createFont("Segoe UI Bold", 21));
    text(retweets, 93, 360);

    //textTweet
    fill(255);
    rect(32, 93, 562, 180);
    
    fill(1);
    textAlign(LEFT, TOP);
    textFont(createFont("Segoe UI", 31));
    textLeading(38);
    text(textTweet, 32, 83, 565, 200);
  }
}
