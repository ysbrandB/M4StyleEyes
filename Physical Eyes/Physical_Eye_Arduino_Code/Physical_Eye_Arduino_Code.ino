//Ysbrand Burgstede Physical Eye Project M4 for blinking physical eyes

#include <Wire.h>
#include <Adafruit_PWMServoDriver.h>

//Adafruit_PWMServoDriver pwm = Adafruit_PWMServoDriver();
Adafruit_PWMServoDriver pwmLeft = Adafruit_PWMServoDriver(0x40);
Adafruit_PWMServoDriver pwmRight = Adafruit_PWMServoDriver(0x60);

#define EYEPAIRAMOUNT 6

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

void setup() {
  Serial.begin(9600);

  for (int i = 0; i < EYEPAIRAMOUNT; i++) {
    blinking[i] = false;
  }

  for (int i = 0; i < EYEPAIRAMOUNT; i++) {
    xAngles[i] =90;
    yAngles[i] = 90;
    blinkingValues[i] = 0;
  }
  pwmLeft.begin();
  pwmLeft.setPWMFreq(60);  // Analog servos run at ~60 Hz updates

  pwmRight.begin();
  pwmRight.setPWMFreq(60);  // Analog servos run at ~60 Hz updates
}

void loop() {
  for (int i = 0; i < EYEPAIRAMOUNT; i++) {//for each set of eyes
    Adafruit_PWMServoDriver pwm;
    int modulatedCounter;

    //set the servodriver to the left or the right
    if (i < EYEPAIRAMOUNT / 2) {
      //modulatedcounter is voor het rechterservoboard het i-het aantal ogen op links
      modulatedCounter=i;
      pwm = pwmLeft;
    } else {
      pwm = pwmRight;
      modulatedCounter=i-(EYEPAIRAMOUNT/2);
    }
    //decide to randomly blink
    if (random(0, 2000) < 2) {
      blinking[i] = true;
    }

    int xval = xAngles[i];
    int yval = yAngles[i];

    //LEFT RIGHT
    xPulse = map(xval, ANGLEMINLEFT, ANGLEMAXRIGHT, 220, 450);
    //xPulse = map(analogRead(A0),0, 1023, 220, 450);
    pwm.setPWM((0 + modulatedCounter * 4), 0, xPulse);
    //UP DOWN

    yPulse = map(yval, ANGLEMINDOWN, ANGLEMAXUP, 520, 280);
    //yPulse = map(analogRead(A1),0, 1023, 520, 280);
    pwm.setPWM((1 + modulatedCounter * 4), 0, yPulse);

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
    pwm.setPWM((2 + modulatedCounter * 4), 0, map(blinkingValues[i], 0, 100, 500, 160));
    pwm.setPWM((3 + modulatedCounter * 4), 0, map(blinkingValues[i], 0, 100, 230, 560));
  }

  delay(10);
}

boolean id = false;
String eyeId = "";
boolean nextAngle = false;
String angleX;
String angleY;

void serialEvent() {
  while (Serial.available()) {
    // get the new byte:
    char inChar = (char)Serial.read();

    //als het einde van een oog is bereikt reset alle variabelen
    if (inChar == '|') {
      //UPDATE HIER DE SERVOS!
      int tempId = eyeId.toInt();
      int tempXAngle = angleX.toInt();
      int tempYAngle = angleY.toInt();
      xAngles[tempId] = constrain(tempXAngle, ANGLEMINLEFT, ANGLEMAXRIGHT);
      yAngles[tempId] = constrain(tempYAngle, ANGLEMINDOWN, ANGLEMAXUP);

       if (tempId == 0) {
        Serial.println(tempYAngle);
      }
      
      id = false;
      eyeId = "";
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
