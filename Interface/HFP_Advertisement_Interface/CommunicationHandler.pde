//lets get the main communication in this Handler so we can spread all data from here
//
class CommunicationHandler {

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

  //Eye Pos Data
  PVector lookingPos= new PVector(0, 0, 0);//the vector the eyes have to look at
  Client eyePosClient;
  String eyeIp = "127.0.0.1";
  int eyePort = 10001;
  JSONObject setUpData;
  int screenWidthCM;
  float swPixDIVswCM;

  //Eyes width conversion

  PApplet context;
  int pollingRate = 2; //polls per second

  //Arduino serial com
  Serial port;


  CommunicationHandler(PApplet parent) {
    clothingColor = color(0);
    context = parent;
    connectClothes();
    connectKinect();
    connectEyes();

    try {
      port = new Serial(parent, Serial.list()[3], 9600);  // open the port!
    }
    catch(Exception e) {
      println("no arduino connected");
    }

    //calculate the conversion for the screen
    try {
      setUpData = loadJSONObject("../../Physical eyes/settings.JSON");
      JSONObject kinectData= setUpData.getJSONObject("Screen");
      screenWidthCM=kinectData.getInt("screenWidth");
    }
    catch(Exception e) {
      println("The JSON setup file is inaccessible, defaulting to a screen of 100 cm");
      screenWidthCM=100;
    }
    swPixDIVswCM=width/screenWidthCM;
  }

  void update() {
    //reconnect clients if needed.
    if (!isConnected(clothesClient) && frameCount % 240 == 0) {
      connectClothes();
    }
    if (!isConnected(kinectClient) && frameCount % 240 == 0) {
      connectKinect();
    }
    if (!isConnected(eyePosClient) && frameCount % 240 == 0) {
      connectEyes();
    }

    //if a client isn't connected then stop this method.
    //if(!isConnected(clothesClient) || !isConnected(kinectClient)) return;

    if (frameCount % ((int)frameRate / pollingRate) == 0) {
      if (clothesClient.available() > 0) {
        decodeClothes(clothesClient.readStringUntil('\n'));
        clothesClient.clear();
      }

      if (kinectClient.available() > 0) {
        decodeKinect(kinectClient.readStringUntil('\n'));
        kinectClient.clear();
      } 
      if (eyePosClient.available() > 0) {
        decodeEyes(eyePosClient.readStringUntil('\n'));
        eyePosClient.clear();
      }
    }
  }

  void connectClothes() {
    try {
      clothesClient = new Client(context, clothesIp, clothesPort);
      println("connected to clothing recognition server");
    } 
    catch (Exception e) {
      println("can't connect to server");
    }
  }

  void connectKinect() {
    try {
      kinectClient = new Client(context, kinectIp, kinectPort);
    } 
    catch (Exception e) {
      println("can't connect to the kinect server");
    }
  }

  void connectEyes() {
    try {
      eyePosClient = new Client(context, eyeIp, eyePort);
    } 
    catch (Exception e) {
      println("can't connect to the eye server");
    }
  }

  void decodeClothes(String input) {
    String[] values = split(input, ',');
    clothingType = values[0];
    try {
      clothingColor = color(Integer.parseInt(values[1]), Integer.parseInt(values[2]), Integer.parseInt(values[3]));
      values[4] = values[4].substring(0, values[4].length() - 1); //removes the \n
      hits = Integer.parseInt(values[4]);
    }
    catch(Exception e) {
      clothingColor = color(0);
      hits = 0;
    }
  }

  void decodeKinect(String input) {
    if (input.contains("Start")) {
      distanceTrigger=true;
    }
  }

  void decodeEyes(String ontvangen) {
    String[] temp=split(ontvangen, ",");
    //ontvangen= (x, y, z) 
    //ontvangen=in meters;
    //to convert to pixels do meters times pixels/meters ratio and add half the screen
    float x=float(temp[0])*swPixDIVswCM;
    float y=float(temp[1])*swPixDIVswCM;
    float z=float(temp[2])*swPixDIVswCM;
    lookingPos=PVector.add(new PVector(x, y, z), new PVector(width/2, height/2));
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
    } 
    catch (Exception e) {
      println("Can't write to port, try to reconnect!");
    }
  }
  PVector getLookingPos() {
    return lookingPos;
  }
}
