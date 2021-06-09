//lets get the main communication in this Handler so we can spread all data from here
//
//Marnix's code should **NOT** be placed here MAKE A DIFFERENT CLASS FOR THAT.

  class CommunicationHandler{

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
  PVector clothingColor;
  String clothingType = "";
  int hits = 0; //the amount of times this type of clothing has been recognised.
  Client clothesClient;
  String clothesIp = "127.0.0.1";
  int clothesPort = 6969;

  //Kinect pos detection.
  boolean overCross; //the user is over the red cross
  Client kinectClient;
  String kinectIp = "127.0.0.1";
  int kinectPort = 10000;


  CommunicationHandler(PApplet parent){
    clothingColor = new PVector();
    connectClothes(parent);
    connectKinect(parent);
  }

  void update(PApplet parent){
    //reconnect clients if needed.
    if(!isConnected(clothesClient) && frameCount % 30 == 0) {
      connectClothes(parent);
    }
    if(!isConnected(kinectClient) && frameCount % 30 == 0) {
      connectKinect(parent);
    }

    //if a client isn't connected then stop this method.
    if(!isConnected(clothesClient) || !isConnected(kinectClient)) return;

    if(clothesClient.available() > 0){
      decodeClothes(clothesClient.readStringUntil('\n'));
    }

    if(kinectClient.available() > 0){
      decodeKinect(kinectClient.readStringUntil('\n'));
    }
  }

  void connectClothes(PApplet parent){
    try {
      clothesClient = new Client(parent, clothesIp, clothesPort);
    } catch (Exception e) {
      println("can't connect to server");
    }
  }

  void connectKinect(PApplet parent){
    try {
      kinectClient = new Client(parent, kinectIp, kinectPort);
    } catch (Exception e) {
      println("can't connect to the kinect server");
    }
  }

  void decodeClothes(String input){
    String[] values = split(input, ',');
    
    clothingType = values[0];
    try {
      clothingColor = new PVector(Integer.parseInt(values[3]), Integer.parseInt(values[2]), Integer.parseInt(values[1]));
      hits = Integer.parseInt(values[4]);
    }catch(Exception e) {
      println("Couldn't parse int, defaulting to 0...");
      clothingColor = new PVector();
      hits = 0;
    }
  }

  void decodeKinect(String input){
    if(input.contains("Start")){
      distanceTrigger=true;
    }    
  }

  boolean isConnected(Client c) {
    return c != null && c.active();
  }
}
