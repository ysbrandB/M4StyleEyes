
int pinRed = 9;
int pinGreen = 10;
int pinBlue = 11;

void setup() {
  pinMode(pinRed, OUTPUT);
  pinMode(pinGreen, OUTPUT);
  pinMode(pinBlue, OUTPUT);
  analogWrite(pinRed, 0);
  analogWrite(pinGreen, 255);
  analogWrite(pinBlue, 255);
}

void loop() {
  for (int red = 0; red < 255; red++) {
    analogWrite(pinRed, red);
    analogWrite(pinGreen, 255-red);
    delay(10);
  }
  for (int green = 0; green < 255; green++) {
    analogWrite(pinGreen, green);
    analogWrite(pinBlue, 255-green);
    delay(10);
  }
  for (int blue = 0; blue < 255; blue++) {
    analogWrite(pinBlue, blue);
    analogWrite(pinRed, 255-blue);
    delay(10);
  }
}
