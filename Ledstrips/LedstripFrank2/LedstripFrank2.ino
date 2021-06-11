#include <FastLED.h>

#define LED_PIN     5
#define NUM_LEDS    100 //300
#define BRIGHTNESS  255 //255 is max
#define LED_TYPE    WS2811
#define COLOR_ORDER GRB

CRGB leds[NUM_LEDS];

#define UPDATES_PER_SECOND 100
int timer;

String buff = "";
char terminator = ',';
int currentColor = 0;
int red = 0;
int green = 0;
int blue = 0;
boolean shouldUpdate = false;

boolean scanning = true;
int scanTimer = 0;

void setup() {
  delay( 3000 ); // power-up safety delay
  FastLED.addLeds<LED_TYPE, LED_PIN, COLOR_ORDER>(leds, NUM_LEDS).setCorrection( TypicalLEDStrip );
  FastLED.setBrightness(  BRIGHTNESS );
  timer = 0;

  //startup color:
  for(int timer = 0; timer<=NUM_LEDS+5; timer++){
    for (int i = 0; i < NUM_LEDS; i++) {
      int fade = abs(i - timer);
      if (fade < 5){
        fade = 1/((float(fade)+1)/2) * 255;
      } else fade = 0;
      leds[i] = CHSV(170, 187, fade);
    }
    FastLED.show();
  }

  Serial.begin(9600);
}

void loop() {
  if (Serial.available() > 0) {
    String valueStr = Serial.readStringUntil(terminator);
    if (valueStr != "") {
      int value = valueStr.toInt();
      switch (currentColor) {
        case 0:
          red = value;
          break;
        case 1:
          green = value;
          break;
        case 2:
          blue = value;
          break;
      }

      currentColor++;
      if (currentColor > 2) {
        currentColor = 0;
        shouldUpdate = true;
      }
    } else {
      currentColor = 0;
    }
  }

  if (shouldUpdate) {
    for (int i = 0; i < NUM_LEDS; ++i) {
      leds[i].setRGB(red, green, blue);
    }
    FastLED.show();
    shouldUpdate = false;
    scanTimer = 0;
  }
  else if(scanning){
    for (int i = 0; i < NUM_LEDS; i++) {
      int fade = abs(i - scanTimer);
      if (fade < 5){
        fade = 1/((float(fade)+1)/2) * 255;
      } else fade = 0;
      leds[i] = CHSV(170, 187, fade);
    }
    FastLED.show();
    scanTimer++;
    if(scanTimer > NUM_LEDS) scanTimer = 0;
  }

  



  //  delay(1 / UPDATES_PER_SECOND);
}
