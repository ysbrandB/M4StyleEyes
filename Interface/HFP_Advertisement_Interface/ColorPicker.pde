class ColorPicker {
  PVector lightRed = new PVector(255, 0, 0);
  PVector darkRed = new PVector(165, 0, 0);
  PVector lightOrange = new PVector(255, 155, 5);
  PVector darkOrange = new PVector(190, 115, 0);
  PVector lightYellow = new PVector(255, 255, 0);
  PVector darkYellow = new PVector(190, 185, 0);
  PVector lightGreen = new PVector(0, 255, 0);
  PVector darkGreen = new PVector(0, 115, 0);
  PVector lightBlue = new PVector(0, 160, 255);
  PVector darkBlue = new PVector(0, 0, 255);
  PVector lightPurple = new PVector(160, 110, 255);
  PVector darkPurple = new PVector(70, 0, 220);
  PVector lightPink = new PVector(255, 140, 245);
  PVector darkPink = new PVector(210, 5, 195);
  PVector lightBrown = new PVector(145, 95, 5);
  PVector darkBrown = new PVector(100, 65, 0);
  PVector white = new PVector(255, 255, 255);
  PVector lightGrey = new PVector(190, 190, 190);
  PVector darkGrey = new PVector(110, 110, 110);
  PVector black = new PVector(0, 0, 0);

  PVector[] knownColors = {};

  String[] knownColorNames = {"Light Red", "Dark Red", "Light Orange", "Dark Orange", "Light Yellow", "Dark Yellow", "Light Green", "Dark Green", "Light Blue", "Dark Blue", "Light Purple", "Dark Purple", "Light Pink", "Dark Pink", "Light Brown", "Dark Brown", "White", "Light Grey", "Dark Grey", "Black"}; 

  PVector receivedColor = new PVector(0, 0, 0);

  String determinedColorName= "Test";
  String opositeDeterminedColorName= "";

  ColorPicker(int tempColorR, int tempColorG, int tempColorB) {
    receivedColor = new PVector(tempColorR, tempColorG, tempColorB);
    knownColors = new PVector[20];
    knownColors[0] = lightRed;
    knownColors[1] = darkRed;
    knownColors[2] = lightOrange;
    knownColors[3] = darkOrange;
    knownColors[4] = lightYellow;
    knownColors[5] = darkYellow;
    knownColors[6] = lightGreen;
    knownColors[7] = darkGreen;
    knownColors[8] = lightBlue;
    knownColors[9] = darkBlue;
    knownColors[10] = lightPurple;
    knownColors[11] = darkPurple;
    knownColors[12] = lightPink;
    knownColors[13] = darkPink;
    knownColors[14] = lightBrown;
    knownColors[15] = darkBrown;
    knownColors[16] = white;
    knownColors[17] = lightGrey;
    knownColors[18] = darkGrey;
    knownColors[19] = black;
  }

  void update() {
    float minDistance = 10000;
    PVector determinedColor = new PVector(0, 0, 0);
    for (int i =0; i<= knownColors.length-1; i++) {
      if (PVector.dist(knownColors[i], receivedColor) < minDistance) {
        minDistance = PVector.dist(knownColors[i], receivedColor);
        determinedColor = knownColors[i];
        determinedColorName = knownColorNames[i];
      }
    }
    float maxDistance = 0;
    PVector opositeDeterminedColor = new PVector(0, 0, 0);
    for (int i =0; i<= knownColors.length-1; i++) {
      if (PVector.dist(knownColors[i], receivedColor) > maxDistance) {
        maxDistance = PVector.dist(knownColors[i], receivedColor);
        opositeDeterminedColor = knownColors[i];
        opositeDeterminedColorName = knownColorNames[i];
      }
    }
  println("RGB value determined color: " + determinedColor, "RGB value oposite determined color: " + opositeDeterminedColor);
  }
  

  String getDeterminedColorName() {
    return determinedColorName;
  }
  
  String getOpositeDeterminedColorName() {
    return opositeDeterminedColorName;
  }
}
