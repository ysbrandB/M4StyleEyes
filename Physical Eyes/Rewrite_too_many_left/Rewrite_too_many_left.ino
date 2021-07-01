// Example 5 - Receive with start- and end-markers combined with parsing
//Frank Bosman Physical Eye Project M4 for blinking physical eyes

#include <Wire.h>
#include <Adafruit_PWMServoDriver.h>

Adafruit_PWMServoDriver pwmDriver = Adafruit_PWMServoDriver(0x60);

#define EYEPAIRAMOUNT 3

#define SERVOMIN  130 //minimum pulselength for servo
#define SERVOMAX  610 // maximum pulselength for servo

#define ANGLEMINLEFT 45
#define ANGLEMAXRIGHT 135

#define ANGLEMINDOWN 80
#define ANGLEMAXUP 100

int xAngles[EYEPAIRAMOUNT];
int yAngles[EYEPAIRAMOUNT];
bool blinking[EYEPAIRAMOUNT];
int blinkingValues[EYEPAIRAMOUNT];

int xPulse;
int yPulse;

const byte numChars = 32;
char receivedChars[numChars];
char tempChars[numChars];        // temporary array for use when parsing

// variables to hold the parsed data
int ontvangenId = 0;
int ontvangenXAngle = 0;
int ontvangenYAngle = 0;
boolean newData = false;

//============

void setup() {
  Serial.begin(9600);
  Serial.println("This code expects 3 pieces of data: <id, xYngle, yAngle>");

  for (int i = 0; i < EYEPAIRAMOUNT; i++) {
    xAngles[i] = 90;
    yAngles[i] = 90;
    blinkingValues[i] = 0;
    blinking[i] = false;
  }

  pwmDriver.begin();
  pwmDriver.setPWMFreq(60);  // Analog servos run at ~60 Hz updates
}

//============

void loop() {
  recvWithStartEndMarkers();
  if (newData == true) {
    strcpy(tempChars, receivedChars);
    // this temporary copy is necessary to protect the original data
    //   because strtok() used in parseData() replaces the commas with \0
    parseData();
    showParsedData();
    newData = false;
  }

  //makes the eyes do shit
  for (int i = 0; i < EYEPAIRAMOUNT; i++) {//for each set of eyes
    int modulatedCounter = i;

    int xval = xAngles[i];
    int yval = yAngles[i];

    //LEFT RIGHT
    xPulse = map(xval, ANGLEMINLEFT, ANGLEMAXRIGHT, 220, 450);
    //xPulse = map(analogRead(A0), 0, 1023, 220, 450);
    pwmDriver.setPWM((0 + modulatedCounter * 4), 0, xPulse);

    //UP DOWN
    yPulse = map(yval, ANGLEMINDOWN, ANGLEMAXUP, 520, 280);
    //yPulse = map(analogRead(A1), 0, 1023, 520, 280);
    pwmDriver.setPWM((1 + modulatedCounter * 4), 0, yPulse);

    //decide to randomly blink
    if (random(0, 2000) < 2) {
          blinking[i] = true;
    }

    //ramp the blinking value up and down to 100
    if (blinking[i]) {
      if (blinkingValues[i] < 100) {
        blinkingValues[i] += 5;
      } else {
        blinking[i] = false;
      }
    } else {
      if (blinkingValues[i] > 0) {
        blinkingValues[i] -= 3;
      }
    }
    //set the blinking servos to the right values
    pwmDriver.setPWM((2 + modulatedCounter * 4), 0, map(blinkingValues[i], 0, 100, 500, 160));
    pwmDriver.setPWM((3 + modulatedCounter * 4), 0, map(blinkingValues[i], 0, 100, 230, 560));
  }
}

//============

void recvWithStartEndMarkers() {
  static boolean recvInProgress = false;
  static byte ndx = 0;
  char startMarker = '<';
  char endMarker = '>';
  char rc;

  while (Serial.available() > 0 && newData == false) {
    rc = Serial.read();

    if (recvInProgress == true) {
      if (rc != endMarker) {
        receivedChars[ndx] = rc;
        ndx++;
        if (ndx >= numChars) {
          ndx = numChars - 1;
        }
      }
      else {
        receivedChars[ndx] = '\0'; // terminate the string
        recvInProgress = false;
        ndx = 0;
        newData = true;
      }
    }

    else if (rc == startMarker) {
      recvInProgress = true;
    }
  }
}

//============

void parseData() {      // split the data into its parts

  char * strtokIndx; // this is used by strtok() as an index

  strtokIndx = strtok(tempChars, ",");
  int ontvangenIdFUCKINGNUTTELOOS = atoi(strtokIndx);

  strtokIndx = strtok(NULL, ",");
  ontvangenId = atoi(strtokIndx);  

  strtokIndx = strtok(NULL, ",");
  ontvangenXAngle = atoi(strtokIndx);

  strtokIndx = strtok(NULL, ",");
  ontvangenYAngle = atoi(strtokIndx);

//  Serial.println((String) ontvangenIdFUCKINGNUTTELOOS + ", " + (String) ontvangenId + ", " + (String) ontvangenXAngle + ", " + (String) ontvangenYAngle + ", " );
}


//============

void showParsedData() {
  ontvangenXAngle = constrain(ontvangenXAngle, ANGLEMINLEFT, ANGLEMAXRIGHT);
  ontvangenYAngle = constrain(ontvangenYAngle, ANGLEMINDOWN, ANGLEMAXUP);
//  Serial.println("id: " + (String)ontvangenId + ", xAngle " + (String)ontvangenXAngle + " ,yAngle: " + (String)ontvangenYAngle);
  xAngles[ontvangenId] = ontvangenXAngle;
  yAngles[ontvangenId] = ontvangenYAngle;
}
