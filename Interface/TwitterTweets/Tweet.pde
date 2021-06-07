
class Tweet {

  PImage backgroundTweet;
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

  Tweet(PImage backgroundTweet) {
    this.backgroundTweet = backgroundTweet;
    date = "8:19 PM • Feb 2, 2021";
    randomHour = int(random(13));
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

  void display() {
    image(backgroundTweet, width/2, height/2);
    noStroke();
    fill(255);
    rect(30, 310, 205, 25);
    fill(110, 118, 125);
    textAlign(LEFT, TOP);
    textFont(createFont("Segoe UI", 20));
    text(date, 33, 309);
  }
}
