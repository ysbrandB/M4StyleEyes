//HFP CreaTe 2021 
//By Sterre Kuijper <Team Leader>, Frank Bosman, Jesse Boomkamp, Ysbrand Brugstede, Jelle Gerritsen,  Max Liebe, Marnix Lueb & Kimberley Siemons
//The Style Eyes Project
//Advertisement Interface of Style Eyes
//Press R to Start

import processing.sound.*;

int phaseCount;
float phaseTimer;
int t1 = 0;

Boolean distanceTrigger;

Boolean hasPlayed;

String colorGet;
String colorRecommend;

PFont pOneMainText; //Font for the main text in phase one
PFont pTwoMainText; //Font for the main text in phase two
PFont pThreeMainText; //Font for the main text in phase three

PhaseZero pZero;
PhaseOne pOne;
PhaseTwo pTwo;
PhaseThree pThree;

SpeechSynth speechSynth;
ColorPicker colorPicker;

void setup() {

  fullScreen(); 
  //size(1600, 800); //for testing only
  imageMode(CENTER);

  pOneMainText = createFont("Font/ARLRDBD_0.TTF", 80); //lettertype Arial rounded MT Bold
  pTwoMainText = createFont("Font/ARLRDBD_0.TTF", 40); //lettertype Arial rounded MT Bold
  pThreeMainText = createFont("Font/ARLRDBD_0.TTF", 80); //lettertype Arial rounded MT Bold

  //initialize all phases
  pZero = new PhaseZero();
  pOne = new PhaseOne(pOneMainText);
  pTwo = new PhaseTwo(pTwoMainText);
  pThree = new PhaseThree(pThreeMainText);
  
  //initialize the speech synthesizer
  speechSynth = new SpeechSynth();

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
    //println("Zero" + t1);  // Prints "Zero"
    break;

  case 1:
    pOne.display();
    speechSynth.aiRecommend(); 
    //phaseCount++;
    println("One");  // Prints "One"
    break;

  case 2: 
    pTwo.display();
    //phaseCount++;
    println("Two");  // Prints "Two"
    break;

  case 3:
    pThree.display();
    //phaseCount++;
    println("Three");  // Prints "Three"
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
}

void keyPressed() {
  if (key == 'r' || key == 'R') {
    colorGet = "RED";
    distanceTrigger = true;
    println(colorGet);
  }

  if (key == BACKSPACE) {
    phaseCount = 0;
    println(colorGet);
  }
}

void keyReleased() { //testing
  distanceTrigger = false;
}
