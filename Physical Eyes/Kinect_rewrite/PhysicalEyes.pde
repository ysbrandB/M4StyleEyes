class PhysicalEyes {
  PApplet context;
  int tokens=3;
  JSONArray eyePosData;
  ArrayList<Eye> eyes = new ArrayList<Eye>();
  PVector kinectPos;
  Serial port;
  boolean arduinoConnected=false;
  PhysicalEyes(PApplet context, PVector kinectPos) {
    this.context=context;
    this.kinectPos=kinectPos;
    //make an eye for every json eye
    eyePosData = loadJSONArray("../EyePos.JSON");
    for (int i = 0; i < eyePosData.size(); i++) {
      JSONObject eye = eyePosData.getJSONObject(i);
      eyes.add(new Eye(new PVector(eye.getFloat("x"), eye.getFloat("y"), eye.getFloat("z")), eye.getInt("id"), kinectPos));
    }
    //print the available serial (arduino ports)
    println("Available serial ports:");
    for (int i = 0; i<Serial.list().length; i++) { 
      print("[" + i + "] ");
      println(Serial.list()[i]);
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

      String arduinoPayload="<"+eye.id+","+int(eye.angleY)+","+int(eye.angleZ)+">";
      if (!eye.oldData.equals(arduinoPayload)) {
        eye.oldData=arduinoPayload;
        try {
          port.write(arduinoPayload);
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
      port = new Serial(context, Serial.list()[arduinoPortNumber], 9600);
      port.bufferUntil('\n');
      arduinoConnected=true;
      println("EyeArduino Connected!");
    }
    catch(Exception e) {
      arduinoConnected=false;
      println("EyeArduino not Connected!");
    }
  }
}
void serialEvent(Serial p) { 
  print(p.readString());
} 
