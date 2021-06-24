class PhaseZero {
  int amount=5000;
  int counter=0;
  int time=0;
  CommunicationHandler com;
  ArrayList <Eye> eyes = new ArrayList <Eye>();
  float area;
  int blinkFrameCount=0;

  PhaseZero(CommunicationHandler com) {
    this.com=com;
    eyes.add(new Eye(width/2, height/2, 200));
    area = width * height;
    for (int i = 0; i < amount; i ++) {
      eyes.add(new Eye(eyes));
      counter++;
      if (areaEyes/area >= 0.4) {
        println("Eyes are full!");
        break;
      }
    }  
    println(counter);
  }

  void display() {
    background(0);
    time +=1;

    //draw eyes
    for (Eye eye : eyes) {
      eye.update(com.lookingPositions);
      eye.display();
    }
    //make the eyes blink by per a random amount of frames
    if (frameCount>blinkFrameCount) {
      blinkFrameCount=frameCount+int(random(10, 50));
      for (Eye eye : eyes) {
        eye.checkToGoBlink();
      }
    }
  }
}
