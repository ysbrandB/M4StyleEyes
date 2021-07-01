#include <FastLED.h>

#define LED_PIN     5
#define NUM_LEDS    197 //300
#define BRIGHTNESS  255 //255 is max
#define LED_TYPE    WS2811
#define COLOR_ORDER GRB

CRGB leds[NUM_LEDS];

//comminucation:
String buff = "";
String commType = "";
int currentColor = 0;
int currentCom = 0;

//plain colors:
int red = 0;
int green = 0;
int blue = 0;
boolean shouldUpdateColors = false;
int pRed[5];
int pGreen[5];
int pBlue[5];

//scanning
boolean scanning = true;
boolean straveForward = true;
float scanTimer = 0;
int scanningHue = 0;
int pScanningHue[5];
static float SCAN_SPEED = 400; //inverse speed, 400 is standart.

//polls:
boolean pollActive = false;
int pollPercentage = 50;
int oppositeColor[3];
int pPollPercentage[5];
int pOppositeColor[3][5];

void setup() {
  delay( 3000 ); // power-up safety delay
  FastLED.addLeds<LED_TYPE, LED_PIN, COLOR_ORDER>(leds, NUM_LEDS).setCorrection( TypicalLEDStrip );
  FastLED.setBrightness(  BRIGHTNESS );

  //startup color:
  for (int timer = 0; timer <= NUM_LEDS + 5; timer++) {
    for (int i = 0; i < NUM_LEDS; i++) {
      int fade = abs(i - timer);
      if (fade < 5) {
        fade = 1 / ((float(fade) + 1) / 2) * 255;
      } else fade = 0;
      leds[i] = CHSV(170, 187, fade);
    }
    FastLED.show();
  }

  Serial.begin(9600);
}

void loop() {
  if (Serial.available() > 0) { //serial comminucation
    int inputInt = Serial.read();
    if (inputInt != 13) serialCom((char)inputInt);
  }

  //fill complete colors        ----------------------------------------------------
  if (shouldUpdateColors) {
    for (int i = 0; i < NUM_LEDS; ++i) {
      leds[i].setRGB(red, green, blue);
    }
    FastLED.show();
    shouldUpdateColors = false;
    scanTimer = 0;
  }
  else if (scanning) { //scanning ----------------------------------------------------
    for (int i = 0; i < NUM_LEDS; i++) {
      int distance = abs(i - int(scanTimer));
      int fade = 0;
      if (distance <10) {
        fade = abs(255 - 255 / 5 * float(distance));
      }

      if(distance<=5) leds[i] = CHSV(scanningHue, 255, fade);//187, fade);
      else leds[i] = CHSV(0, 0, fade);
    }
    FastLED.show();
    if (straveForward) {
      scanTimer += ((float)NUM_LEDS) / SCAN_SPEED;
      if (scanTimer > NUM_LEDS - 10) straveForward = false;
    } else {
      scanTimer -= ((float)NUM_LEDS) / SCAN_SPEED;
      if (scanTimer < 10) straveForward = true;
    }
  } else if (pollActive) {
    for (int i = 0; i < NUM_LEDS; i++) {
      if((float) i / (float) NUM_LEDS * 100 <= pollPercentage) leds[i].setRGB(red, green, blue);
      else leds[i].setRGB(oppositeColor[0], oppositeColor[1], oppositeColor[2]);
    }
    FastLED.show();
  }

}

void serialCom(char inputChar) {
  if (inputChar == '\n') { //end of the comm -------------------------------------------------------
    decode(buff);
    if (commType == "color") { //if the sent command is change color:
      shouldUpdateColors = true;
      //reset the modes:
      scanning = false;
      pollActive = false;

      red = constrain(arrayMax(pRed), 0, 255);
      green = constrain(arrayMax(pGreen), 0, 255);
      blue = constrain(arrayMax(pBlue), 0, 255);
      Serial.println("" + (String)red + " " + (String)green + " " + (String)blue);
    }
    if (commType == "scan") { //if the send command is scan:
      scanning = true;
      //reset the modes:
      shouldUpdateColors = false;
      pollActive = false;
    }
    if (commType == "poll") {
      pollActive = true;
      //reset the modes:
      scanning = false;
      shouldUpdateColors = false;
      
      red = constrain(arrayMax(pRed), 0, 255);
      green = constrain(arrayMax(pGreen), 0, 255);
      blue = constrain(arrayMax(pBlue), 0, 255);

      oppositeColor[0] = constrain(arrayMax(pOppositeColor[0]), 0, 255);
      oppositeColor[1] = constrain(arrayMax(pOppositeColor[1]), 0, 255);
      oppositeColor[2] = constrain(arrayMax(pOppositeColor[2]), 0, 255);
      Serial.println("" + (String)red + "," + (String)green + "," + (String)blue + "|" + (String)oppositeColor[0] + "," + (String)oppositeColor[1] + "," + (String)oppositeColor[2]);
    }
    if(commType == "percentage"){
      pollPercentage = constrain(arrayMax(pPollPercentage), 0, 100);
    }

    commType = "";

    clearArray(pRed);
    clearArray(pGreen);
    clearArray(pBlue);

    clearArray(pOppositeColor[0]);
    clearArray(pOppositeColor[1]);
    clearArray(pOppositeColor[2]);

    clearArray(pPollPercentage);
    
    currentCom = 0;
    buff = "";
  } else if (inputChar == '|') { //end of the line ----------------------------------------------------
    decode(buff);
    buff = "";
    currentCom++;
    //    commType = "";
    if (currentCom >= sizeof(pRed)) currentCom = sizeof(pRed) - 1;
    currentColor = 0;
    Serial.print("|");
  } else if (inputChar != ',') { // normale charactor ------------------------------------------------
    buff += inputChar;
  } else { //when it sees a comma, -------------------------------------------------------------------
    decode(buff);
    buff = "";
  }
}

void decode(String input) {
  input.trim();
  Serial.print(input + ",");

  if (commType == "") {
    commType = input;
    commType.toLowerCase();
    Serial.println(commType);
  } else {
    if (contains(commType, "co")) {
      commType = "color";
      int value = buff.toInt();
      switch (currentColor) {
        case 0:
          pRed[currentCom] = value;
          break;
        case 1:
          pGreen[currentCom] = value;
          break;
        case 2:
          pBlue[currentCom] = value;
          break;
      }
      currentColor++;
    }
    else if (contains(commType, "sc")) { //scan(ning):
      commType == "scan";
    } else if (contains(commType, "po")) { //poll(ing):
      commType = "poll";
      int value = buff.toInt();
      switch (currentColor) {
        case 0:
          pRed[currentCom] = value;
          break;
        case 1:
          pGreen[currentCom] = value;
          break;
        case 2:
          pBlue[currentCom] = value;
          break;
        case 3: pOppositeColor[0][currentCom] = value;
          break;
        case 4:
          pOppositeColor[1][currentCom] = value;
          break;
        case 5:
          pOppositeColor[2][currentCom] = value;
          break;
      }
//      Serial.print((String) value + " ");
      currentColor++;
    } else if(contains(commType, "per")){
      commType = "percentage";
      int value = buff.toInt();
      pPollPercentage[currentCom] = value;
    }
  }

}

boolean contains(String str, String contain) {
  return str.indexOf(contain) >= 0;
}

int arrayMax(int input[]) {
  int maximum = 0;
  for (int i = 0; i < sizeof(input); i++) {
    if (input[i] > maximum) maximum = input[i];
  }
  return maximum;
}

void clearArray(int input[]) {
  for (int i = 0; i < sizeof(input); i++) {
    input[i] = 0;
  }
}
