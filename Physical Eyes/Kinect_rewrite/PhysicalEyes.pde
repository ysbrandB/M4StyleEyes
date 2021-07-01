class PhysicalEyes {
  PApplet context;
  JSONArray eyePosData;
  ArrayList<Eye> eyes = new ArrayList<Eye>();
  PVector kinectPos;
  Serial leftPort;
  Serial rightPort;
  
  PhysicalEyes(PApplet context, PVector kinectPos) {
    this.context=context;
    this.kinectPos=kinectPos;
    //make an eye for every json eye
    eyePosData = loadJSONArray("../EyePos.JSON");
    for (int i = 0; i < eyePosData.size(); i++) {
      JSONObject eye = eyePosData.getJSONObject(i);
      eyes.add(new Eye(new PVector(eye.getFloat("x"), eye.getFloat("y"), eye.getFloat("z")), eye.getInt("id"), kinectPos));
    }
    //init the port
    connectArduino();
  }
  
  void show() {
    //show the eyes
    for (Eye eye : eyes) {
      eye.show();
    }
  }
  
  void update() {
    //update all the eyes, and send the data to the arduino
    for (Eye eye : eyes) {
      eye.update();
      //stuur alleen de data als de hoeken verander zijn

      String arduinoPayload="<"+eye.id + "," + eye.id+"," +int(eye.angleY)+","+int(eye.angleZ)+">";
      //println("Processing sends:" +arduinoPayload);
      if (!eye.oldData.equals(arduinoPayload)) {
        eye.oldData=arduinoPayload;
        try {
          if (eye.pos.x<0) {
            leftPort.write(arduinoPayload);
          } else {
            rightPort.write(arduinoPayload);
          }
        }
        catch(Exception e) {
          if (frameCount%360==0) {
            connectArduino();
          }
        }
      }
    }
  }

  void connectArduino() {
    try {
      leftPort = new Serial(context, Serial.list()[leftArduinoPortNumber], 9600);
      leftPort.bufferUntil('\n');
      println("LeftEyeArduino Connected!");
    }
    catch(Exception e) {
      println("LeftEyeArduino not Connected!");
    }
    try {
      rightPort = new Serial(context, Serial.list()[rightArduinoPortNumber], 9600);
      rightPort.bufferUntil('\n');
      println("RightEyeArduino Connected!");
    }
    catch(Exception e) {
      println("rightEyeArduino not Connected!");
    }
  }
}
void serialEvent(Serial p) { 
  print(p.readString());
} 
