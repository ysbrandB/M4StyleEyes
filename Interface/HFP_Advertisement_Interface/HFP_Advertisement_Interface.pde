//HFP CreaTe 2021 
//By Sterre Kuijper <Team Leader>, Frank Bosman, Jesse Boomkamp, Ysbrand Brugstede, Jelle Gerritsen,  Max Liebe, Marnix Lueb & Kimberley Siemons
//The Style Eyes Project
//Advertisement Interface of Style Eyes

//libraries:
import processing.net.*;

//TCP clients
Client personOnCrossClient;

//communicationHandler
ComHandler communicationHandler;

int phaseCount;
float phaseTimer;
int t1 = 0;

Boolean distanceTrigger;

String colorGet;
String colorRecommend;

PhaseZero pZero;
PhaseOne pOne;
PhaseTwo pTwo;
PhaseThree pThree;

PFont pOneMainText; //Font for the main text in phase one
PFont pTwoMainText; //Font for the main text in phase two
PFont pThreeMainText; //Font for the main text in phase three

void setup() {
  //Setup TCP
  personOnCrossClient = new Client(this, "127.0.0.1", 10000);//listening port and ip
  communicationHandler=new ComHandler();
  fullScreen(); 
  //size(800, 800);
  imageMode(CENTER);

  pOneMainText = createFont("Font/ARLRDBD_0.TTF", 80); //lettertype Arial rounded MT Bold
  pTwoMainText = createFont("Font/ARLRDBD_0.TTF", 40); //lettertype Arial rounded MT Bold
  pThreeMainText = createFont("Font/ARLRDBD_0.TTF", 80); //lettertype Arial rounded MT Bold

  pZero = new PhaseZero();
  pOne = new PhaseOne(pOneMainText);
  pTwo = new PhaseTwo(pTwoMainText);
  pThree = new PhaseThree(pThreeMainText);

  phaseCount = 0;
  phaseTimer = 1;

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

  //update current phase
  if (phaseTimer > 0) {
    phaseTimer -= 1/frameRate;
  } else if (phaseCount != 0 || (distanceTrigger && phaseCount == 0)) {
    phaseCount++;
    if (phaseCount > 3) phaseCount = 0;

    switch(phaseCount) { //determines the length of the next phase 
    case 1:
      phaseTimer = 5;
      break;
    case 2: 
      phaseTimer = 8; 
      break;
    case 3: 
      phaseTimer = 8; 
      break;
     case 0:
      phaseTimer = 3;
    }
  }
  
  communicationHandler.getInfo();
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
