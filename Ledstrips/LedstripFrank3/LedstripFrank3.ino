#include <FastLED.h>

#define LED_PIN     5
#define NUM_LEDS    100 //300
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
  // put your main code here, to run repeatedly:
  if (Serial.available() > 0) {
    int inputInt = Serial.read();
    if (inputInt != 13) serialCom((char)inputInt);
  }

  if (shouldUpdateColors) {
    for (int i = 0; i < NUM_LEDS; ++i) {
      leds[i].setRGB(red, green, blue);
    }
    FastLED.show();
    shouldUpdateColors = false;
    scanTimer = 0;
  }
  else if(scanning){
    for (int i = 0; i < NUM_LEDS; i++) {
      int fade = abs(i - int(scanTimer));
      if (fade < 5) {
        fade = 255 - 255 / 5 * float(fade);
      } else fade = 0;
      leds[i] = CHSV(scanningHue, 255, fade);//187, fade);
    }
    FastLED.show();
    if (straveForward) {
      scanTimer += ((float)NUM_LEDS)/SCAN_SPEED;
      if (scanTimer > NUM_LEDS) straveForward = false;
    } else {
      scanTimer -= ((float)NUM_LEDS)/SCAN_SPEED;
      if (scanTimer < 0) straveForward = true;
    }
  }
  
}

void serialCom(char inputChar) {
  if(inputChar == '\n'){
    decode(buff);
    if(commType == "color") {//if the sent command is change color:
      shouldUpdateColors = true;
      //reset the modes:
      scanning = false;

      red = arrayMax(pRed);
      green = arrayMax(pGreen);
      blue = arrayMax(pBlue);
      Serial.println("" + (String)red + " " + (String)green + " " + (String)blue);

    }
    if(commType == "scan") { //if the send command is scan:
      scanning = true;
      //reset the modes:
      shouldUpdateColors = false;

//      scanningHue = arrayMax(pScanningHue);
    }
    
    commType = "";

    clearArray(pRed);
    clearArray(pGreen);
    clearArray(pBlue);
    
    currentCom = 0;
    buff = "";
  }else if (inputChar == '|') {
    decode(buff);
    buff = "";
    currentCom++;
//    commType = "";
    if(currentCom >= sizeof(pRed)) currentCom = sizeof(pRed)-1;
    currentColor = 0;
  } else if (inputChar != ',') {
    buff += inputChar;
  } else {
    decode(buff);
    buff = "";
  }
}

void decode(String input) {
  input.trim();

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
    else if(contains(commType, "sc")){ //scanning:
      commType == "scan";
//      int value = buff.toInt();
//      Serial.println(value);
//      pScanningHue[currentCom] = value;
    }
//    else commType = "";
  }
}

boolean contains(String str, String contain){
  return str.indexOf(contain) >= 0;
}

int arrayMax(int input[]){
  int maximum = 0;
  for(int i = 0; i < sizeof(input); i++){
    if(input[i] > maximum) maximum = input[i];
  }
  return maximum;
}

void clearArray(int input[]){
  for(int i = 0; i < sizeof(input); i++){
    input[i] = 0;
  }
}
