class ColorPicker {
  String lastName;
  color lastColor;
  String lastOppositeName;
  color lastOppositeColor;

  PVector[] knownColors;
  String[] knownColorNames = {
    "Light Red", 
    "Dark Red", 
    "Light Orange", 
    "Dark Orange", 
    "Light Yellow", 
    "Dark Yellow", 
    "Light Green", 
    "Dark Green", 
    "Light Blue", 
    "Dark Blue", 
    "Light Purple", 
    "Dark Purple", 
    "Light Pink", 
    "Dark Pink", 
    "Light Brown", 
    "Dark Brown", 
    "White", 
    "Light Grey", 
    "Dark Grey", 
    "Black"
  }; 

  ColorPicker() {
    knownColors = new PVector[] {
        new PVector(255, 0, 0),  
        new PVector(165, 0, 0),
        new PVector(255, 155, 5),
        new PVector(190, 115, 0),
        new PVector(255, 255, 0),
        new PVector(190, 185, 0),
        new PVector(0, 255, 0),
        new PVector(0, 115, 0),
        new PVector(0, 160, 255),
        new PVector(0, 0, 255),
        new PVector(160, 110, 255),
        new PVector(70, 0, 220),
        new PVector(255, 140, 245),
        new PVector(210, 5, 195),
        new PVector(145, 95, 5),
        new PVector(100, 65, 0),
        new PVector(255, 255, 255),
        new PVector(190, 190, 190),
        new PVector(110, 110, 110),
        new PVector(0, 0, 0)
    };
  }

  void colorDetermination(PVector givenColor) {
    float minDistance = 10000;
    for (int i = 0; i <= knownColors.length - 1; i++) {
      if(PVector.dist(knownColors[i], givenColor) < minDistance) {
        minDistance = PVector.dist(knownColors[i], givenColor);
        lastColor = color(knownColors[i].x, knownColors[i].y, knownColors[i].z);
        lastName = knownColorNames[i];
      }
    }
    float maxDistance = 0;
    for (int i = 0; i <= knownColors.length - 1; i++) {
      if(PVector.dist(knownColors[i], givenColor) > maxDistance) {
        maxDistance = PVector.dist(knownColors[i], givenColor);
        lastOppositeColor = color(knownColors[i].x, knownColors[i].y, knownColors[i].z);
        lastOppositeName = knownColorNames[i];
      }
    }
  }
  
  String getLastColorName() {
    return lastName;
  }
  
  color getLastColor(){
    return lastColor;
  }
  
  String getLastOppositeColorName() {
    return lastOppositeName;
  }
  
  color getLastOppositeColor(){
    return lastOppositeColor;
  }
}