//// Have Fun & Play Project
//// Style Eyes Speech Synthesizer
//// By Jelle Gerritsen

class SpeechSynth {

  static final int colour_amount = 9;
  static final int clothingtype_amount = 5;
  static final int maxpause_amount = 6;
  static final float soundamp = 0.1;

  Boolean recomHasPlayed = false;
  boolean isPlaying = false;

  int detClColour = 0;
  int detClType = 0;
  int recClColour = int(random(0, colour_amount));
  int recClType = int(random(0, clothingtype_amount));

  int speakTimer;
  int pauseCounter;

  int [] speakPause = {1200, 600, 1400, 600, 500, 800};

  String colorRecog; 
  String clothTypeRecog;
  String clothRecog;

  String colorRecom;
  String clothTypeRecom;
  String clothRecom;

  SoundFile youRWearingA;
  SoundFile [] colour = new SoundFile [colour_amount];
  SoundFile [] clothingtype = new SoundFile [clothingtype_amount];
  SoundFile a;
  SoundFile wouldFitYouWayBetter;

  Delay roboDelay;

  SpeechSynth() {

    colorRecog = "Blue"; 
    clothTypeRecog = "Sweater";

    colorRecom = "White";
    clothTypeRecom = "Polo";

    clothRecog = colorRecog + "" + clothTypeRecog;
    clothRecom = colorRecom + "" + clothTypeRecom;

    speakTimer = speakPause[0];
    pauseCounter = 0;

    roboDelay = new Delay(HFP_Advertisement_Interface.this);

    youRWearingA = new SoundFile(HFP_Advertisement_Interface.this, "wav/youarewearinga.wav");
    a = new SoundFile(HFP_Advertisement_Interface.this, "wav/A.wav");
    wouldFitYouWayBetter = new SoundFile(HFP_Advertisement_Interface.this, "wav/wouldfityouwaybetter.wav");

    roboDelay.process(youRWearingA, 0.04);
    roboDelay.process(a, 0.04);
    roboDelay.process(wouldFitYouWayBetter, 0.04);

    for (int i = 0; i < colour_amount; i++) {
      colour[i] = new SoundFile(HFP_Advertisement_Interface.this, "wav/cr" + i + ".wav");
      roboDelay.process(colour[i], 0.04);
    }

    for (int i = 0; i < clothingtype_amount; i++) {
      clothingtype[i] = new SoundFile(HFP_Advertisement_Interface.this, "wav/ct" + i + ".wav");
      roboDelay.process(clothingtype[i], 0.04);
    }

    roboDelay.set(0.018, 0.55);
  }

  void aiRecommend() {
    if (speakTimer<=0) {
      isPlaying=false;
    }

    if (speakTimer > 0) {
      speakTimer -= 1000/frameRate;
    } else if (pauseCounter < 7) {
      pauseCounter++;
      if(pauseCounter<6){
      speakTimer = speakPause[pauseCounter];
      }
    }

    if (!recomHasPlayed&&!isPlaying) {
      println(pauseCounter);
      switch(pauseCounter) { //determines the length of the next phase 
      case 0:
        youRWearingA.amp(soundamp);
        youRWearingA.play();
        isPlaying=true;
        break;
      case 1: 
        colour[detClColour].amp(soundamp);
        colour[detClColour].play();
        isPlaying=true;
        break;
      case 2: 
        clothingtype[detClType].amp(soundamp);
        clothingtype[detClType].play(); 
        isPlaying=true;
        break;
      case 3:
        a.amp(soundamp);
        a.play();
        isPlaying=true;
        break;
      case 4:
        colour[recClColour].amp(soundamp);
        colour[recClColour].play();
        isPlaying=true;
        break;
      case 5:
        clothingtype[recClType].amp(soundamp);
        clothingtype[recClType].play();
        isPlaying=true;
        break;
      case 6:
        wouldFitYouWayBetter.amp(soundamp);
        wouldFitYouWayBetter.play();
        isPlaying=true;
        recomHasPlayed=true;
        break;
      case 7:
        recomHasPlayed=false;
        pauseCounter=0;
        isPlaying=false;
        speakTimer=0;
      }
    }
  }

  //  if (!recomHasPlayed) {
  //    //analyse sentence
  //    youRWearingA.amp(soundamp);
  //    youRWearingA.play();
  //    delay(speakPause[pauseCounter]);
  //    colour[detClColour].amp(soundamp);
  //    colour[detClColour].play();
  //    delay(speakPause[pauseCounter]);
  //    clothingtype[detClType].amp(soundamp);
  //    clothingtype[detClType].play();
  //    delay(1400);

  //    //recommendation sentence
  //    a.amp(soundamp);
  //    a.play();
  //    delay(500);
  //    colour[recClColour].amp(soundamp);
  //    colour[recClColour].play();
  //    delay(600);
  //    clothingtype[recClType].amp(soundamp);
  //    clothingtype[recClType].play();
  //    delay(800);
  //    wouldFitYouWayBetter.amp(soundamp);
  //    wouldFitYouWayBetter.play();
  //  }

  //  recomHasPlayed = true;
}
