//lets get the main communication in this Handler so we can spread all data from here
//
//Marnix's code should be placed here

class ComHandler {

  String colorRecog;
  String clothTypeRecog;
  String clothRecog;

  String colorRecom;
  String clothTypeRecom;
  String clothRecom;

  int recogClrR;
  int recogClrG;
  int recogClrB;

  static final int maxHValue = 360; //this value should be checked

  int recogClrH;
  int recogClrS;
  int recogClrV;

  ComHandler() {
    colorMode(HSB, maxHValue, 100, 100);

    clothRecog = colorRecog + "" + clothTypeRecog;
    clothRecom = colorRecom + "" + clothTypeRecom;
  }
  void getInfo(){
  getInfoFromCrossServer();
  }

  void getInfoFromCrossServer() {
    // krijgt de string "Start" gesplit door commas als er iemand op het kruis gaat staan!
    String inputFromCross="";
    if (personOnCrossClient.available() >=6) { // receive data
      inputFromCross=personOnCrossClient.readString();    
      if(inputFromCross.contains("Start")){
        println(inputFromCross);
        distanceTrigger=true;
      }
      println(inputFromCross);
    }
  }

  //only reverses the Hue and not the Brightness or Saturation
  color reverseColor() {
    int H = maxHValue - recogClrH; 
    int S = recogClrS;
    int V = recogClrV;
    return color(H, S, V);
  }
}
