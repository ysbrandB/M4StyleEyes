class ColorPicker {
  String detectedColorName;
  color detectedColor;
  String oppositeColorName;
  color oppositeColor;

  JSONObject colorData;
  JSONArray colors;
  
  int maxGreyscaleDifference = 60;
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
  }
  
  String getLastColorName() {
    return detectedColorName;
  }
  
  color getLastColor(){
    return detectedColor;
  }
  
  String getLastOppositeColorName() {
    return oppositeColorName;
  }
  
  color getLastOppositeColor(){
    return oppositeColor;
  }
  
  color intArrayToColor(int[] rgb) {
    return color(rgb[0], rgb[1], rgb[2]);
  }
}
