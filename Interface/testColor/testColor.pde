InputColor inputColor;

JSONObject colorData;
JSONObject inputColors;
JSONObject oppisiteColors;
String detectedColorName;
color detectedColor;
String oppisiteColorName;
color oppisiteColor;


void setup() {
  size(800, 800);
  inputColor = new InputColor();

  colorData = loadJSONObject("./Colors.JSON");
  inputColors = colorData.getJSONObject("inputColors");
  oppisiteColors = colorData.getJSONObject("oppisiteColor");

  detectedColorName = "None";
  detectedColor = color(0);
}

void draw() {
  inputColor.display();
  
  determinColor(inputColor.getColor());
  oppisiteColor();
}

private void determinColor(color inputColor){
  // colorMode(HSB);
  float hue = map(hue(inputColor), 0, 255, 0, 360);
  float saturation = map(saturation(inputColor), 0, 255, 0, 100);
  float brightness = map(brightness(inputColor), 0, 255, 0, 100);
  
  detectedColorName = "None";

  //determin the color
  if(saturation <= 20){ //for white, grays and black.
    if(brightness >= 90) detectedColorName = "White";
    else if(brightness >= 60) detectedColorName = "Light Grey";
    else if(brightness >= 25) detectedColorName = "Dark Grey";
    else detectedColorName = "Black";
  }
  else if(hue <= 13 || hue >= 337){ //red shit
    if(saturation <= 60 && brightness >= 80) detectedColorName = "Light Red";
    else if(brightness <= 80 && brightness >= 25) detectedColorName = "Dark Red";
    else if(brightness < 25) detectedColorName = "Black";
    else detectedColorName = "Red";
  } 
  else if(hue > 13 && hue <= 42){ //orange shit also brown
    if(brightness > 70 && saturation > 70) detectedColorName = "Orange";
    else if(brightness >= 20) detectedColorName = "Brown";
    else if (brightness < 20) detectedColorName = "Black";
  }
  else if(hue > 42 && hue <= 64){ //yellow shit
    if(hue <= 50 && brightness >= 20) detectedColorName = "Dark Yellow";
    else if(brightness > 55) detectedColorName = "Yellow";
    else if(brightness > 20) detectedColorName = "Dark Yellow";
    else detectedColorName = "Black";
  }
  else if(hue > 64 && hue <= 162){ //green shit
    //lime, green, and dark green
    if(brightness >= 85) detectedColorName = "Lime";
    else if(brightness >= 66) detectedColorName = "Green";
    else if (brightness >= 15) detectedColorName = "Dark Green";
    else detectedColorName = "Black";
  }
  else if(hue > 162 && hue <= 250){ //blue shit
    // light blue, blue, dark blue, turquoise
    if(brightness <= 15) detectedColorName = "Black";
    else if(hue < 180) detectedColorName = "Turquoise";
    else if(((saturation >= 58 && brightness >= 59) || hue < 200 && brightness < 75) && hue < 220) detectedColorName = "Light Blue";
    else if(brightness > 90) detectedColorName = "Blue";
    else detectedColorName = "Dark Blue";
  }
  else if(hue > 250 && hue <= 295){ //purple shit
    //purple, dark purple
    if(brightness <= 20) detectedColorName = "Black";
    else if((hue<260 && saturation < 81) || brightness < 65) detectedColorName = "Dark Purple";
    else detectedColorName = "Purple";
  }
  else if(hue > 295 && hue < 337){ //pink shit
    if(brightness <= 25) detectedColorName = "Black";
    else if(brightness <= 60) detectedColorName = "Dark Purple";
    else detectedColorName = "Pink";
  }

  //gets the corresponding color form the json file
  int[] rgbColor = inputColors.getJSONArray(detectedColorName).getIntArray();
  detectedColor = color(rgbColor[0], rgbColor[1], rgbColor[2]);



  //testing
  fill(detectedColor);
  stroke(0);
  rect(width-200, 25, 175, 175);

  textSize(50);
  fill(255);
  text(detectedColorName, 5, 50);
  // println(hue, saturation, brightness, detectedColorName);
}

private void oppisiteColor(){
  String[] oppisiteColorArray = split(detectedColorName, ' ');
  if(oppisiteColorArray.length == 1) oppisiteColorName = oppisiteColorArray[0]; //when there is no light or dark
  else oppisiteColorName = oppisiteColorArray[1]; //remove the light or dark

  oppisiteColorName = oppisiteColors.getString(oppisiteColorName);

  //gets the corresponding color form the json file
  int[] rgbColor = inputColors.getJSONArray(oppisiteColorName).getIntArray();
  oppisiteColor = color(rgbColor[0], rgbColor[1], rgbColor[2]);


  //testing
  fill(oppisiteColor);
  stroke(0);
  rect(width-200, height-200, 175, 175);

  text(oppisiteColorName, 5, height-5);
}
