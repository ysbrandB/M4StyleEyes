#include <Servo.h>

bool fullUpdate = false;  // whether the full update is complete
//test string: 1,38,-41|2,125,-125|3,33,-36|4,26,-26|5,153,-131|6,28,-50|7,141,-161|\n
int angles[60];
int servoAmount = 30;
int angleAmount = servoAmount * 2;
Servo testServo;
void setup() {
  // initialize serial:
  Serial.begin(9600);
  //init the whole array to 0's
  for (int i = 0; i < sizeof(angleAmount); i++) {
    angles[i] = 0;
  }
  testServo.attach(3);
  testServo.write(0);
  delay(4000);
  testServo.write(180);
  delay(4000);
}

void loop() {
  // print the string when a newline arrives:
  if (fullUpdate) {
    fullUpdate = false;
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
   //als een \n er is en we dus een volledige update hebben gehad zet 
    if (inChar == '\n') {
      fullUpdate = true;
      break;
    }
    
    //als het einde van een oog is bereikt reset alle variabelen
    if (inChar == '|') {
      //UPDATE HIER DE SERVOS!
      Serial.println("" + eyeId +","+ angleX+","+ angleY+'\n');
      if(eyeId.toInt()==0){
      testServo.write(180-angleX.toInt());
      }
      id = false;
      //Has to be eyeid but have to stop so fix later
      eyeId="";
      nextAngle = false;
      angleX = "";
      angleY = "";
      break;
    }
    //als er een comma is is er of de eerste angle of de volgende angle dus switch dan
    if (inChar == ',') {
      //switch van de id string naar de angle string
      if (!id) {
        id = true;
      }
      else {
        //switch van de angleX string naar de angle Y string
        nextAngle = true;
      }
      break;
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
