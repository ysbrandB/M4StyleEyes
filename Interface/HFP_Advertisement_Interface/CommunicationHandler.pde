//lets get the main communication in this Handler so we can spread all data from here
//
class CommunicationHandler {

  //AI clothing recognition.
  color clothingColor;
  String clothingType = "short_sleeve_top";
  int hits = 0; //the amount of times this type of clothing has been recognised.
  Client clothesClient;
  String clothesIp = "127.0.0.1";
  int clothesPort = 6969;

  //Kinect pos detection.
  boolean overCross; //the user is over the red cross
  Client kinectClient;
  String kinectIp = "127.0.0.1";
  int kinectPort = 10006;

  //Eye Pos Data
  ArrayList <PVector> lookingPositions= new ArrayList <PVector>();
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
  Serial ledPort;
  boolean ledConnected=false;

  CommunicationHandler(PApplet parent) {
    lookingPositions.add(new PVector(width/2, height/2, 200));
    clothingColor = color(0);
    context = parent;
    connectClothes();
    connectKinect();
    connectEyes();
    connectLEDS();


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
    //FUCK YSBRAND
    swPixDIVswCM=width/screenWidthCM;
  }

  void update() {
    //Only poll the eyes when in phase 0 as fast as possible
    if (eyePosClient.available() > 0) {
      decodeEyes(eyePosClient.readStringUntil('\n'));
      eyePosClient.clear();
    }
    //only poll the servers in the startup phases aka when not playing audio!
    if (phaseCount==0||phaseCount==1) {
      //reconnect clients if needed.
      if (!isConnected(clothesClient) && frameCount % 240 == 0) {
        //connectClothes();
      }
      if (!isConnected(kinectClient) && frameCount % 240 == 0) {
        connectKinect();
      }
      if (!isConnected(eyePosClient) && frameCount % 240 == 0) {
        //connectEyes();
      }
      if (!ledConnected&& frameCount % 240 == 0) {
        //connectLEDS();
      }

      if ((int)frameRate > pollingRate && frameCount % ((int)frameRate / pollingRate) == 0) {
        if (clothesClient.available() > 0) {
          decodeClothes(clothesClient.readStringUntil('\n'));
          clothesClient.clear();
        }

        if (kinectClient.available() > 0) {
          decodeKinect(kinectClient.readStringUntil('\n'));
          kinectClient.clear();
        }
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
  void connectLEDS() {
    try {
      ledPort = new Serial(context, Serial.list()[2], 9600);  // open the port!
      ledConnected=true;
    }
    catch(Exception e) {
      ledConnected=false;
      println("no arduino connected");
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
    println("Started interface "+input);
    if (input.contains("Start")) {
      distanceTrigger=true;
    }
  }

  void decodeEyes(String ontvangen) {
    //add all the lookingvectors for every person in sight
    //delete the last '\n'
    if ( ontvangen.charAt( ontvangen.length()-1) == '\n' ) {
      ontvangen = ontvangen.substring( 0, ontvangen.length()-1 );
    }
    lookingPositions= new ArrayList <PVector>();
    String[] seperateVectors=split(ontvangen, "|");
    for (String vector : seperateVectors) {
      String[] temp=split(vector, ",");
      //ontvangen= (x, y, z) 
      //ontvangen=in meters;
      //to convert to pixels do meters times pixels/meters ratio and add half the screen
      float x=float(temp[0])*swPixDIVswCM;
      float y=float(temp[1])*swPixDIVswCM;
      float z=float(temp[2])*swPixDIVswCM;
      lookingPositions.add(PVector.add(new PVector(x, y, z), new PVector(width/2, height/2)));
    }
  }

  boolean isConnected(Client c) {
    return c != null && c.active();
  }

  void sendColor(color inputColor) {
    //color|0,0,255|0,0,255|0,0,255|0,0,255
    int redValue = int(red(inputColor));
    int greenValue = int(green(inputColor));
    int blueValue = int(blue(inputColor));

    String data = redValue + "," + greenValue + "," + blueValue + ",";
    String payload = "Color";
    for (int i = 1; i<5; i++) {
      payload += "|" + data;
    }
    if (ledConnected==true) {
      try {
        ledPort.write(payload + '\n');
      } 
      catch (Exception e) {
        println("Can't write to port, retrying");
      }
    } else {
      println("LEDS not connected!");
    }
  }

  void ledstripScan() {
    String payload = "Scan";
    
    if (ledConnected==true) {
      try {
        ledPort.write(payload + '\n');
      } 
      catch (Exception e) {
        println("Can't write to port");
      }
    } else {
      println("Leds aren't connected!");
    }
  }
}
