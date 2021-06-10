class PhaseThree extends Slide {

  int chpRandomPrice;  //random number generated to calculate all cheap prices
  int expRandomPrice; //random number generated to calculate all expensive prices
  
  Strings string;

  String clothRecom;
  
  String totalRecom; //total message
  String cheapBrand; //the randomly selected cheap brand
  String expensiveBrand; //the randomly selected expensive brand
  String chpBrandPrice; //randomly generated cheap brand price
  String expBrandPrice; //randomly generated expensive brand price
  String chpOriginalPrice; //randomly generated original expensive brand price
  String expOrignialPrice; //randomly generated original expensive brand price
  String encourageMessage; //encourages the person the buy the product

  PhaseThree() {
    clothRecom = "White Polo";
    
    encourageMessage = "But DON'T WORRY! You CAN" + "\n"+ "BUY a " + clothRecom + " too!"; 
    
    cheapBrand = "Jack & Jones"; //placeholder
    expensiveBrand = "Louis Viton"; //placeholder

    chpRandomPrice = int(random(1, 5));
    expRandomPrice = int(random(10, 20));

    chpBrandPrice = chpRandomPrice + "9";
    expBrandPrice =  expRandomPrice + "9";
    
    orgCheapPrice = chpRandomPrice + 1;
    orgExpensivePrice = expRandomPrice + 5;;
    
    chpOriginalPrice = orgCheapPrice + "9";
    expOrignialPrice = orgExpensivePrice + "9";

    totalRecom = "NOW in SALE at" +"\n" + 
      cheapBrand + ": " + chpBrandPrice + "€"+ "  <-  Originally: " + (chpOriginalPrice) + "€" +"\n" + 
      expensiveBrand + ": " + expBrandPrice + "€"+ "  <-  Originally: " + (expOrignialPrice) + "€";
  }

  void display() {
    background(bgColor);

    textFont(fontHeading);
    
    text(encourageMessage, width / 8, height / 4);
    
    text(totalRecom, width / 8, height / 1.5);
  }
}
