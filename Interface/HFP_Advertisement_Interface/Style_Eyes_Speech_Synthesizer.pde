//// Have Fun & Play Project
//// Style Eyes Speech Synthesizer
//// By Jelle Gerritsen



class SpeechSynth {

  static final int colour_amount = 9;
  static final int clothingtype_amount = 5;
  static final int maxpause_amount = 6;
  static final float soundamp = 0.1;
  
  Boolean recomHasPlayed = false;

  int detClColour = 0;
  int detClType = 0;
  int recClColour = int(random(0, colour_amount));
  int recClType = int(random(0, clothingtype_amount));
  
  int speakTimer;
  
  float [] speakPause;

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
    
    speakTimer = 1;
    
    speakPause = new float [maxpause_amount];
    //speakPause[] = [1.2, 0.6, 1.4, 0.6, 0.5, 0.8];

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
   
    if(speakTimer > 0){
      speakTimer -= 1/frameRate;
    }
    
    if(!recomHasPlayed){
    //analyse sentence
    youRWearingA.amp(soundamp);
    youRWearingA.play();
    delay(1200);
    colour[detClColour].amp(soundamp);
    colour[detClColour].play();
    delay(600);
    clothingtype[detClType].amp(soundamp);
    clothingtype[detClType].play();
    delay(1400);

    //recommendation sentence
    a.amp(soundamp);
    a.play();
    delay(500);
    colour[recClColour].amp(soundamp);
    colour[recClColour].play();
    delay(600);
    clothingtype[recClType].amp(soundamp);
    clothingtype[recClType].play();
    delay(800);
    wouldFitYouWayBetter.amp(soundamp);
    wouldFitYouWayBetter.play();
  }
  
  recomHasPlayed = true;
  }
}
