#include <FastLED.h>

#define LED_PIN     5
#define NUM_LEDS    100 //300
#define BRIGHTNESS  255 //255 is max
#define LED_TYPE    WS2811
#define COLOR_ORDER GRB

CRGB leds[NUM_LEDS];

#define UPDATES_PER_SECOND 100
int timer;

//comminucation:
String buff = "";
char terminator = ',';
String commType = "";
int currentColor = 0;

int red = 0;
int green = 0;
int blue = 0;
boolean shouldUpdate = false;

boolean scanning = true;
boolean straveForward = true;
float scanTimer = 0;

void setup() {
  delay( 3000 ); // power-up safety delay
  FastLED.addLeds<LED_TYPE, LED_PIN, COLOR_ORDER>(leds, NUM_LEDS).setCorrection( TypicalLEDStrip );
  FastLED.setBrightness(  BRIGHTNESS );
  timer = 0;

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
  if (Serial.available() > 0) {
//    char input[1];
//    Serial.readBytes(input, 1);
    Serial.println((char) Serial.read());
//    SerialCom((char) Serial.read());
    //    String valueStr = Serial.readStringUntil(terminator);
    //    if (valueStr != "") {
    //      int value = valueStr.toInt();
    //      switch (currentColor) {
    //        case 0:
    //          red = value;
    //          break;
    //        case 1:
    //          green = value;
    //          break;
    //        case 2:
    //          blue = value;
    //          break;
    //      }
    //
    //      currentColor++;
    //      if (currentColor > 2 || valueStr.substring(0) == '\n') {
    //        currentColor = 0;
    //        shouldUpdate = true;
    //
    //        if(red == 0 && green == 0 && blue == 0) scanning = true;
    //        else scanning = false;
    //      }
    //    } else {
    //      currentColor = 0;
    //    }
  }

  if (shouldUpdate) {
    for (int i = 0; i < NUM_LEDS; ++i) {
      leds[i].setRGB(red, green, blue);
    }
    FastLED.show();
    shouldUpdate = false;
    scanTimer = 0;
  }
  else if (scanning) {
    for (int i = 0; i < NUM_LEDS; i++) {
      int fade = abs(i - int(scanTimer));
      if (fade < 5) {
        fade = 255 - 255 / 5 * float(fade);
      } else fade = 0;
      leds[i] = CHSV(170, 187, fade);
    }
    FastLED.show();
    if (straveForward) {
      scanTimer += 0.2;
      if (scanTimer > NUM_LEDS) straveForward = false;
    } else {
      scanTimer -= 0.2;
      if (scanTimer < 0) straveForward = true;
    }
  }
  //  delay(1 / UPDATES_PER_SECOND);
}

void SerialCom(char input) {
  Serial.println(input);
  
//  if (input == '\n') { //if it's the end of the line clear the string and reset the comminucation.
//    buff = "";
//    commType = "";
//
//    if(currentColor > 0) shouldUpdate = true;
//    currentColor = 0;
//  } else if (input != ',') {
//    buff += input; //if it's not a split charactor, add it to the buffer
//  } else { //decode:
//    if (commType == "") {
//      commType = buff;
////      commType.toLowerCase();
////      Serial.write(45);
//      Serial.println(commType);
//    }
//    else {
//      if (commType == "color") {
//        int value = buff.toInt();
//        Serial.println(value);
//        switch (currentColor) {
//          case 0:
//            red = value;
//            break;
//          case 1:
//            green = value;
//            break;
//          case 2:
//            blue = value;
//            break;
//        }
//        currentColor++;
//      }
//    }
//  }
}
