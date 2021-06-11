//HFP CreaTe 2021 
//By Sterre Kuijper <Team Leader>, Frank Bosman, Jesse Boomkamp, Ysbrand Brugstede, Jelle Gerritsen, Max Liebe, Marnix Lueb & Kimberley Siemons
//The Style Eyes Project
//Advertisement Interface of Style Eyes
//Press R to Start

import processing.sound.*;
import processing.net.*;
import processing.serial.*;
CommunicationHandler com;

static final int HITS_THRESHOLD = 5;

int phaseCount;
float phaseTimer;
int t1 = 0;

Boolean distanceTrigger;

Boolean hasPlayed;

ColorPicker colorPicker;
TypePicker typePicker;

PhaseZero pZero;
PhaseOne pOne;
PhaseTwo pTwo;
PhaseThree pThree;

SpeechSynth speechSynth;

void setup() {

  //fullScreen(2); 
  size(1920, 1080); //for testing only
  imageMode(CENTER);

  com = new CommunicationHandler(this);
  colorPicker = new ColorPicker();
  typePicker = new TypePicker();

  //initialize all phases
  pZero = new PhaseZero(com);
  pOne = new PhaseOne(colorPicker, typePicker);
  pTwo = new PhaseTwo(colorPicker, typePicker);
  pThree = new PhaseThree();
  
  //initialize the speech synthesizer
  speechSynth = new SpeechSynth(colorPicker, typePicker);

  //initialize the phaseTimer & phaseCounter
  phaseCount = 0;
  phaseTimer = 1;

  //
  distanceTrigger = false;
}

void draw() {

  switch(phaseCount) {
  case 0:
    pZero.display();
    if(com.hits >= HITS_THRESHOLD && distanceTrigger) {
      colorPicker.colorDetermination(com.clothingColor);
      typePicker.typeDetermination("short_sleeve_top"/*com.clothingType*/);
      distanceTrigger = true;
    }
    //println("Zero" + t1);  // Prints "Zero"
    break;

  case 1:
    pOne.display();
    speechSynth.recommendColor(); 
    //phaseCount++;
    //println("One");  // Prints "One"
    break;

  case 2: 
    pTwo.display();
    //phaseCount++;
    //println("Two");  // Prints "Two"
    break;

  case 3:
    pThree.display();
    //phaseCount++;
    //println("Three");  // Prints "Three"
    break;
  }

  //update current phase, phaseTimer is in seconds
  if (phaseTimer > 0) {
    phaseTimer -= 1/frameRate; 
  } else if (phaseCount != 0 || (distanceTrigger && phaseCount == 0)) {
    phaseCount++;
    if (phaseCount > 3) phaseCount = 0;

    switch(phaseCount) { //determines the length of the next phase 
    case 1:
      phaseTimer = 8;
      break;
    case 2: 
      phaseTimer = 8; 
      break;
    case 3: 
      phaseTimer = 5; 
      break;
     case 0:
      phaseTimer = 2;
    }
  }

  com.update();
}

void keyPressed() {
  if (key == 'r' || key == 'R') {
    com.hits = 5;
    colorPicker.colorDetermination(com.clothingColor);
    distanceTrigger = true;
  }

  if (key == BACKSPACE) {
    phaseCount = 0;
  }
}

void keyReleased() { //testing
  distanceTrigger = false;
}
