//Ysbrand Burgstede Physical Eye Project M4 for blinking physical eyes

int amountEyes = 6;
int xAngles[6];
int yAngles[6];
bool blinking[6];
int blinkingValues[6];
#include <Wire.h>
#include <Adafruit_PWMServoDriver.h>

Adafruit_PWMServoDriver pwm = Adafruit_PWMServoDriver();

#define SERVOMIN  130 // this is the 'minimum' pulse length count (out of 4096)
#define SERVOMAX  610 // this is the 'maximum' pulse length count (out of 4096)

#define ANGLEMINLEFT 45
#define ANGLEMAXRIGHT 135

#define ANGLEMINDOWN 80
#define ANGLEMAXUP 100

int xval;
int yval;

int xPulse;
int yPulse;

void setup() {
  pinMode(A0, INPUT);
  pinMode(A1, INPUT);
  Serial.begin(9600);
  Serial.println("Ysbrand dit gaat niet werken lmao");
  pwm.begin();
   pwm.setPWM(1, 0, 520);
  pwm.setPWMFreq(60);  // Analog servos run at ~60 Hz updates
  
  for (int i = 0; i < 6; i++) {
    blinking[i] = false;
  }

  for (int i = 0; i < sizeof(xAngles); i++) {
    xAngles[i] = 90;
    yAngles[i] = 90;
    blinkingValues[i] = 0;
  }
  delay(100);
}

void loop() {
  for (int i = 0; i < 6; i++) {
    if (random(0, 500) < 2) {
      blinking[i] = true;
    }

    xval = xAngles[0];
    yval = yAngles[0];

    //LEFT RIGHT
    xPulse = map(xval, ANGLEMINLEFT, ANGLEMAXRIGHT, 220, 450);
    //xPulse = map(analogRead(A0),0, 1023, 220, 450);
    pwm.setPWM(0, 0, xPulse);

    //UP DOWN
    yPulse = map(yval, ANGLEMINDOWN, ANGLEMAXUP, 520, 280);
    // yPulse = map(analogRead(A1),0, 1023, 520, 280);
    //Serial.println(yPulse);
    pwm.setPWM(1, 0, yPulse);

    if (blinking[i]) {
      if (blinkingValues[i] < 100) {
        blinkingValues[i]+=10;
      } else {
        blinking[i] = false;
      }
    } else {
      if (blinkingValues[i] > 0) {
        blinkingValues[i]-=5;
      }
    }

    pwm.setPWM(2, 0, map(blinkingValues[0], 0, 100, 500, 160));
    pwm.setPWM(3, 0, map(blinkingValues[0], 0, 100, 230, 560));
    
    delay(1);
  }
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
      Serial.println("" + eyeId + "," + angleX + "," + angleY + '\n');
      int tempId = eyeId.toInt();
      int tempXAngle = angleX.toInt();
      int tempYAngle = angleY.toInt();
      xAngles[tempId] = constrain(tempXAngle, ANGLEMINLEFT, ANGLEMAXRIGHT);
      yAngles[tempId] = constrain(tempYAngle, ANGLEMINDOWN, ANGLEMAXUP);

      id = false;
      //Has to be eyeid but have to stop so fix later
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
