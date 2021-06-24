class ColorPicker {
  String detectedColorName;
  color detectedColor;
  String oppositeColorName;
  color oppositeColor;

  JSONObject colorData;
<<<<<<< HEAD
  JSONArray colors;
  
  int maxGreyscaleDifference = 20;
  int maxHueDifference = 10;
  int maxSaturationDifference = 10;
  int maxBrightnessDifference = 10;
  

  ColorPicker() {
    colorData = loadJSONObject("./JsonFiles/Colors.JSON");
    colors = colorData.getJSONArray("colors");
  }

  void colorDetermination(color inputColor) {
    //reset colors in case something goes wrong
    detectedColorName = "White";
    detectedColor = color(255, 255, 255);
    oppositeColorName = "Black";
    oppositeColor = color(0, 0, 0);
    
    //get color parameters
    int r = (int)red(inputColor);
    int g = (int)green(inputColor);
    int b = (int)blue(inputColor);
    int hue = (int)hue(inputColor);
    int saturation = (int)saturation(inputColor);
    int brightness = (int)brightness(inputColor);
    
    //check if color is grayscale
    boolean grayScale = false;
    if(abs(r - b) <= maxGreyscaleDifference 
    && abs(r - g) <= maxGreyscaleDifference 
    && abs(g - b) <= maxGreyscaleDifference) {
      grayScale = true;
=======
  JSONObject inputColors;
  JSONObject oppositeColors;


  ColorPicker() {
    colorData = loadJSONObject("../JsonFiles/Colors.JSON");
    inputColors = colorData.getJSONObject("inputColors");
    oppositeColors = colorData.getJSONObject("oppisiteColor");

    detectedColorName = "None";
    detectedColor = color(0, 255, 0);
  }

  void colorDetermination(color inputColor) {
    float hue = map(hue(inputColor), 0, 255, 0, 360);
    float saturation = map(saturation(inputColor), 0, 255, 0, 100);
    float brightness = map(brightness(inputColor), 0, 255, 0, 100);

    detectedColorName = "None";

    //determine the color
    if (saturation <= 20) { //for white, grays and black.
      if (brightness >= 90) detectedColorName = "White";
      else if (brightness >= 60) detectedColorName = "Light Grey";
      else if (brightness >= 25) detectedColorName = "Dark Grey";
      else detectedColorName = "Black";
    } else if (hue <= 13 || hue >= 337) { //red shit
      if (saturation <= 60 && brightness >= 80) detectedColorName = "Light Red";
      else if (brightness <= 80 && brightness >= 25) detectedColorName = "Dark Red";
      else if (brightness < 25) detectedColorName = "Black";
      else detectedColorName = "Red";
    } else if (hue > 13 && hue <= 42) { //orange shit also brown
      if (brightness > 70 && saturation > 70) detectedColorName = "Orange";
      else if (brightness >= 20) detectedColorName = "Brown";
      else if (brightness < 20) detectedColorName = "Black";
    } else if (hue > 42 && hue <= 64) { //yellow shit
      if (hue <= 50 && brightness >= 20) detectedColorName = "Dark Yellow";
      else if (brightness > 55) detectedColorName = "Yellow";
      else if (brightness > 20) detectedColorName = "Dark Yellow";
      else detectedColorName = "Black";
    } else if (hue > 64 && hue <= 162) { //green shit
      //lime, green, and dark green
      if (brightness >= 85) detectedColorName = "Lime";
      else if (brightness >= 66) detectedColorName = "Green";
      else if (brightness >= 15) detectedColorName = "Dark Green";
      else detectedColorName = "Black";
    } else if (hue > 162 && hue <= 250) { //blue shit
      // light blue, blue, dark blue, turquoise
      if (brightness <= 15) detectedColorName = "Black";
      else if (hue < 180) detectedColorName = "Turquoise";
      else if (((saturation >= 58 && brightness >= 59) || hue < 200 && brightness < 75) && hue < 220) detectedColorName = "Light Blue";
      else if (brightness > 90) detectedColorName = "Blue";
      else detectedColorName = "Dark Blue";
    } else if (hue > 250 && hue <= 295) { //purple shit
      //purple, dark purple
      if (brightness <= 20) detectedColorName = "Black";
      else if ((hue<260 && saturation < 81) || brightness < 65) detectedColorName = "Dark Purple";
      else detectedColorName = "Purple";
    } else if (hue > 295 && hue < 337) { //pink shit
      if (brightness <= 25) detectedColorName = "Black";
      else if (brightness <= 60) detectedColorName = "Dark Purple";
      else detectedColorName = "Pink";
>>>>>>> d0028c6d2dfa69c3033bc8ae19e4abe4492f856c
    }

    //filter through all the colors and find the best match
    JSONObject closestColor = null;
    int adjHueDifference = maxHueDifference;
    int adjSaturationDifference = maxSaturationDifference;
    int adjBrightnessDifference = maxBrightnessDifference;
    while(closestColor == null) {
        int closestBrightness = 1000;
        boolean foundHue = false;
        boolean foundSaturation = false;
        boolean foundBrightness = false;
        
        for(int i = 0; i < colors.size(); i++) {
          //read the rgb color from the JSON database
          JSONObject colorObject = colors.getJSONObject(i);
          color dbColor = intArrayToColor(colorObject.getJSONArray("rgb").getIntArray());
          
          if(!grayScale) {
            //get the hue and establish the closest hue
            int dbHue = (int)hue(dbColor);
            int dbSaturation = (int)saturation(dbColor);
            int dbBrightness = (int)brightness(dbColor);
            if(abs(hue - dbHue) <= adjHueDifference) {
              foundHue = true;
              if(abs(saturation - dbSaturation) <= adjSaturationDifference) {
                foundSaturation = true;
                if(abs(brightness - dbBrightness) <= adjBrightnessDifference) {
                  foundBrightness = true;
                  //this color is a definite better choice, so make it the new best match
                  closestColor = colorObject;
                }
              }
            }
          }else if(colorObject.getBoolean("grayscale")){
            int dbBrightness = (int)brightness(dbColor);
            if(abs(brightness - dbBrightness) < abs(brightness - closestBrightness)) {
              //this matches the color the closest in terms of brightness, so make it the new best match
              closestBrightness = dbBrightness;
              closestColor = colorObject;
            }
          }
        }
        if(!foundHue) adjHueDifference += 10;
        else if(!foundSaturation) adjSaturationDifference += 10;
        else if(!foundBrightness) adjBrightnessDifference += 10;
    }
    
    //update the detected color and opposite color
    detectedColorName = closestColor.getString("name");
    detectedColor = intArrayToColor(closestColor.getJSONArray("rgb").getIntArray());
    oppositeColorName = closestColor.getString("opposite");
    for(int i = 0; i < colors.size(); i++) {
      JSONObject obj = colors.getJSONObject(i);
      if(obj.getString("name").equals(oppositeColorName)) {
        oppositeColor = intArrayToColor(obj.getJSONArray("rgb").getIntArray());
      }
    }
<<<<<<< HEAD
=======

    //oppisite color -------------------------------------------
    String[] oppositeColorArray = split(detectedColorName, ' ');
    if (oppositeColorArray.length == 1) oppositeColorName = oppositeColorArray[0]; //when there is no light or dark
    else oppositeColorName = oppositeColorArray[1]; //remove the light or dark

    oppositeColorName = oppositeColors.getString(oppositeColorName);

    //gets the corresponding color form the json file
    int[] rgbColor = inputColors.getJSONArray(oppositeColorName).getIntArray();
    oppositeColor = color(rgbColor[0], rgbColor[1], rgbColor[2]);
>>>>>>> d0028c6d2dfa69c3033bc8ae19e4abe4492f856c
  }

  String getLastColorName() {
    return detectedColorName;
  }

  color getLastColor() {
    return detectedColor;
  }

  String getLastOppositeColorName() {
    return oppositeColorName;
  }

  color getLastOppositeColor() {
    return oppositeColor;
  }
  
  color intArrayToColor(int[] rgb) {
    return color(rgb[0], rgb[1], rgb[2]);
  }
}
