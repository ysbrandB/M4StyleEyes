bool stringComplete = false;  // whether the string is complete
//test string: 1,38,-41|2,125,-125|3,33,-36|4,26,-26|5,153,-131|6,28,-50|7,141,-161|\n
int angles[60];
int servoAmount = 30;
int angleAmount = servoAmount * 2;

void setup() {
  // initialize serial:
  Serial.begin(9600);
  //init the whole array to 0's
  for (int i = 0; i < sizeof(angleAmount); i++) {
    angles[i] = 0;
  }
}

void loop() {
  // print the string when a newline arrives:
  if (stringComplete) {
    stringComplete = false;
  }
}

/*
  SerialEvent occurs whenever a new data comes in the hardware serial RX. This
  routine is run between each time loop() runs, so using delay inside loop can
  delay response. Multiple bytes of data may be available.
*/

boolean id = false;
String eyeId = "";
boolean nextAngle = false;
String angleX;
String angleY;

void serialEvent() {
  while (Serial.available()) {
    // get the new byte:
    char inChar = (char)Serial.read();

    // if the incoming character is a newline, set a flag so the main loop can
    // do something about it:
    if (inChar == '\n') {
      stringComplete = true;
      break;
    }
    if (inChar == '|') {
      //UPDATE HIER DE SERVOS!
      
      Serial.println("" + eyeId + angleX + angleY);
      id = false;
      //Has to be eyeid but have to stop so fix later
      id="";
      nextAngle = false;
      nextAngle = false;
      angleX = "";
      angleY = "";
      break;
    }
    if (inChar == ',') {
      if (!id) {
        id = true;
      }
      else {
        nextAngle = true;
      }
    }

    if (!id) {
      eyeId += inChar;
    }
    else if (!nextAngle) {
      // add it to the inputString:
      angleX += inChar;
    }
    else {
      angleY += inChar;
    }
  }
}
