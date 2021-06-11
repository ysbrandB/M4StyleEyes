//lets get the main communication in this Handler so we can spread all data from here
//
  class CommunicationHandler{

  //AI clothing recognition.
  color clothingColor;
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
  
  PApplet context;
  int pollingRate = 2; //polls per second

  //Arduino serial com
  Serial port;


  CommunicationHandler(PApplet parent){
    clothingColor = color(0);
    context = parent;
    connectClothes();
    connectKinect();

    try{
    port = new Serial(parent, Serial.list()[3], 9600);  // open the port!
    }catch(Exception e){
     println("no arduino connected"); 
    }
  }

  void update(){
    //reconnect clients if needed.
    if(!isConnected(clothesClient) && frameCount % 240 == 0) {
      connectClothes();
    }
    if(!isConnected(kinectClient) && frameCount % 240 == 0) {
      connectKinect();
    }

    //if a client isn't connected then stop this method.
    //if(!isConnected(clothesClient) || !isConnected(kinectClient)) return;

    if(frameCount % ((int)frameRate / pollingRate) == 0) {
      if(clothesClient.available() > 0){
        decodeClothes(clothesClient.readStringUntil('\n'));
        clothesClient.clear();
      }

      if(kinectClient.available() > 0){
        decodeKinect(kinectClient.readStringUntil('\n'));
        kinectClient.clear();
      } 
    }
  }

  void connectClothes(){
    try {
      clothesClient = new Client(context, clothesIp, clothesPort);
      println("connected to clothing recognition server");
    } catch (Exception e) {
      println("can't connect to server");
    }
  }

  void connectKinect(){
    try {
      kinectClient = new Client(context, kinectIp, kinectPort);
    } catch (Exception e) {
      println("can't connect to the kinect server");
    }
  }

  void decodeClothes(String input){
    String[] values = split(input, ',');
    
    clothingType = values[0];
    try {
      clothingColor = color(Integer.parseInt(values[1]), Integer.parseInt(values[2]), Integer.parseInt(values[3]));
      values[4] = values[4].substring(0, values[4].length() - 1); //removes the \n
      hits = Integer.parseInt(values[4]);
    }catch(Exception e) {
      clothingColor = color(0);
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

  void sendColor(color inputColor) {
    int redValue = int(red(inputColor));
    int greenValue = int(green(inputColor));
    int blueValue = int(blue(inputColor));

    String payload = redValue + "," + greenValue + "," + blueValue + ",";
    try {
      port.write(payload);
    } catch (Exception e) {
      println("Can't write to port, try to reconnect!");      
    }    
  }
}
