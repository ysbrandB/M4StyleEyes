//lets get the main communication in this Handler so we can spread all data from here
//
//Marnix's code should **NOT** be placed here MAKE A DIFFERENT CLASS FOR THAT.

  class ComHandler{

  //----- DE GROOTSTE ANTI HENK (BULLSHIT) ------
  // String colorRecog; 
  // String clothTypeRecog;
  // String clothRecog;
  
  // String colorRecom;
  // String clothTypeRecom;
  // String clothRecom;
  
  // int recogClrR;
  // int recogClrG;
  // int recogClrB;
  
  // static final int maxHValue = 360; //HSV will probably not be necessary
  
  // int recogClrH;
  // int recogClrS;
  // int recogClrV;
  
  // ComHandler(){

  // colorMode(HSB, maxHValue, 100, 100);
  
  // clothRecog = colorRecog + "" + clothTypeRecog;
  // clothRecom = colorRecom + "" + clothTypeRecom;
  // }
  
  // //only reverses the Hue and not the Brightness or Saturation
  // color reverseColor(){
  //   int H = maxHValue - recogClrH; 
  //   int S = recogClrS;
  //   int V = recogClrV;
  //   return color(H, S, V);
  // }
  //-----------------------------------------

  //AI clothing recognition.
  String clothColor; 
  String clothType;
  int hits; //the amount of times this type of cloths has been recognised.
  Client clothsClient;
  String clothsIp = "127.0.0.1";
  int clothsPort = 6969;

  //Kinect pos detection.
  boolean overCross; //the user is over the red cross
  Client kinectClient;
  String kinectIp = "127.0.0.1";
  int kinectPort = 1000;


  ComHandler(PApplet parrent){
    connectCloths(parrent);
    connectKinect(parrent);
  }

  void update(PApplet parrent){
    //reconnect clients if needed.
    if((clothsClient == null || (clothsClient != null && !clothsClient.active()) && frameCount%30 == 0)  connectCloths;
    if((kinectClient == null || (kinectClient != null && !kinectClient.active()) && frameCount%30 == 0)  kinectClient;

    //if a client isn't connected then stop this methoud.
    if((clothsClient == null || (clothsClient != null && !clothsClient.active()) || (kinectClient == null || (kinectClient != null && !kinectClient.active())) return;

    if(clothsClient.available() > 0){
      decodeCloths(clothsClient.readStringUntil('\n'));
    }

    if(kinectClient.available() > 0){
      decodeKinect(kinectClient.readStringUntil('\n'));
    }
  }

  void connectCloths(PApplet parrent){
    try {
      clothsClient = new Client(parrent, clothsIp, clothsPort);
    } catch (Exception e) {
      println("can't connect to server");
    }
  }

  void connectKinect(PApplet parrent){
    try {
      kinectclient = new Client(parrent, kinectIp, kinectPort);
    } catch (Exception e) {
      println("can't connect to the kinect server");
    }
  }

  void decodeCloths(String input){
    string[] values = split(input, ',');
    
    clothType = values[0];
    clothColor = new PVector(int(values[1]), int(values[2]), int(values[3]));
    hits = int(values[4]);
  }

  void decodeKinect(String input){

  }

  
}
