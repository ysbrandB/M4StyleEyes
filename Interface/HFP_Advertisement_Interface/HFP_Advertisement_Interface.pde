//HFP CreaTe 2021  //<>//
//By Sterre Kuijper <Team Leader>, Frank Bosman, Jesse Boomkamp, Ysbrand Brugstede, Jelle Gerritsen, Max Liebe, Marnix Lueb & Kimberley Siemons
//The Style Eyes Project
//Advertisement Interface of Style Eyes
//Press R to Start

import processing.sound.*;
import processing.net.*;
import processing.serial.*;
import java.util.Map;
import java.io.File;

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
int areaEyes;
PhaseOne pOne;
PhaseTwo pTwo;
PhaseThree pThree;
PhaseFour pFour;

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
  pOne = new PhaseOne(com);
  pTwo = new PhaseTwo(colorPicker, typePicker);
  pThree = new PhaseThree(colorPicker, typePicker);
  pFour = new PhaseFour();

  //initialize the speech synthesizer
  speechSynth = new SpeechSynth(colorPicker, typePicker);

  //initialize the phaseTimer & phaseCounter
  phaseCount = 0;
  phaseTimer = 1;

  distanceTrigger = false;
}

void draw() {
  speechSynth.speak(); 
  switch(phaseCount) {
  case 0:
    pZero.display();
    break;

  case 1:
    pOne.display();
    break;

  case 2: 
    pTwo.display();
    break;

  case 3: 
    pThree.display();
    break;

  case 4:
    pFour.display();
  }

  //update current phase, phaseTimer is in seconds
  if (phaseTimer > 0) {
    phaseTimer -= 1/frameRate; 
    //check to start from the normal state to change to phase 1 or to the next phase
  } else if ((phaseCount != 0 && phaseCount != 1)|| (distanceTrigger && phaseCount == 0)||(phaseCount==1 && com.hits >= HITS_THRESHOLD)) {
    phaseCount++;
    if (phaseCount > 4) phaseCount = 0;

    switch(phaseCount) { //determines the length of the next phase 
    case 1:
      phaseTimer = 8;
      break;
    case 2: 
      phaseTimer = 8;
      colorPicker.colorDetermination(com.clothingColor);
      typePicker.typeDetermination(com.clothingType);
      pTwo.init(com);
      speechSynth.init(); 
      break;
    case 3: 
      phaseTimer = 16; 
      pThree.init(com);
      break;
    case 4:
      phaseTimer = 10;
      pFour.init(); 
      break;
    case 0:
      distanceTrigger=false;
      phaseTimer = 2; //delay for next time/input
    }
  }
  com.update();
}

void keyPressed() {
  if (key == 'r' || key == 'R') {
    com.hits = 5;
    colorPicker.colorDetermination(com.clothingColor);
  }

  if (key=='d'||key=='D') {
    distanceTrigger=true;
  }

  if (key == BACKSPACE) {
    phaseCount = 0;
  }
}