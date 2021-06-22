
int pinRed = 9;
int pinGreen = 10;
int pinBlue = 11;

String buff = "";
char terminator = ',';
int currentColor = 0;
int red = 0;
int green = 0;
int blue = 0;

void setup() {
  Serial.begin(9600);
  pinMode(pinRed, OUTPUT);
  pinMode(pinGreen, OUTPUT);
  pinMode(pinBlue, OUTPUT);
  analogWrite (pinRed, 255);
  analogWrite (pinGreen, 255);
  analogWrite (pinBlue, 255);
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
      if (currentColor > 2) currentColor = 0;
    } else {
      currentColor = 0;
    }
  }
  analogWrite (pinRed, 255 - red);
  analogWrite (pinGreen, 255 - green);
  analogWrite (pinBlue, 255 - blue);

}
