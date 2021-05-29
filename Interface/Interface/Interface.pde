//setup the TCP Client to know when to start:
import processing.net.*;
Client c;
String ontvangen="";

void setup() {
  c = new Client(this, "127.0.0.1", 10000);//listening port and ip
  size(1000,800);
  textMode(CENTER);
}

void draw() {
  background(255);
  // krijgt de string "Start" gesplit door commas als er iemand op het kruis gaat staan!
  if (c.available() > 0) { // receive data
      ontvangen=c.readString();    
      println(ontvangen);
  }
  
}
