//// Have Fun & Play Project
//// Style Eyes Speech Synthesizer
//// By Jelle Gerritsen

class SpeechSynth {
  static final int COLOR_AMOUNT = 9;
  static final int TYPE_AMOUNT = 5;
  static final int MAX_PAUSE_AMOUNT = 6;
  static final float SOUND_AMP = 0.1;

  int colorIndex = 0;
  int typeIndex = 0;
  int oppositeColorIndex = 0;
  int oppositeTypeIndex = 0;

  int [] speakPause =  {200,200, 200,200, 200, 200};
  float speakTimer=0;
  
  SoundFile youRWearingA;
  SoundFile[] colorSounds = new SoundFile[COLOR_AMOUNT];
  SoundFile[] typeSounds = new SoundFile[TYPE_AMOUNT];
  SoundFile a;
  SoundFile wouldFitYouWayBetter;
  
  ArrayList <SoundFile> soundsToPlay;
  int currentIndex=0;
  float pauseTimer;


  Delay roboDelay;
  ColorPicker colorPicker;
  TypePicker typePicker;

  SpeechSynth(ColorPicker colorPicker, TypePicker typePicker) {
    speakTimer = speakPause[0];
    roboDelay = new Delay(HFP_Advertisement_Interface.this);

    youRWearingA = new SoundFile(HFP_Advertisement_Interface.this, "wav/youarewearinga.wav");
    a = new SoundFile(HFP_Advertisement_Interface.this, "wav/A.wav");
    wouldFitYouWayBetter = new SoundFile(HFP_Advertisement_Interface.this, "wav/wouldfityouwaybetter.wav");

    roboDelay.process(youRWearingA, 0.04);
    roboDelay.process(a, 0.04);
    roboDelay.process(wouldFitYouWayBetter, 0.04);

    for (int i = 0; i < COLOR_AMOUNT; i++) {
      colorSounds[i] = new SoundFile(HFP_Advertisement_Interface.this, "wav/cr" + i + ".wav");
      roboDelay.process(colorSounds[i], 0.04);
    }

    for (int i = 0; i < TYPE_AMOUNT; i++) {
      typeSounds[i] = new SoundFile(HFP_Advertisement_Interface.this, "wav/ct" + i + ".wav");
      roboDelay.process(typeSounds[i], 0.04);
    }

    roboDelay.set(0.018, 0.55);
    this.colorPicker = colorPicker;
    this.typePicker = typePicker;
  }

  void init() {    
    //WORDT 1X PER SEQUENCE UITGEVOERD!
    String colorName = colorPicker.getLastColorName();
    String typeName = typePicker.getLastTypeName();
    String oppositeColorName = colorPicker.getLastOppositeColorName();
    String oppositeTypeName = typePicker.getLastOppositeTypeName();
    //below here needs to be a switch statement that decides index of the sound file based on the color name
    //THESE INDICES SHOULD BE ASSIGNED VIA THE SWITCH STATEMENT!
    colorIndex = 0;
    typeIndex = 0;
    oppositeColorIndex = 0;
    oppositeTypeIndex = 0;
    
    soundsToPlay=new ArrayList<SoundFile>();
    currentIndex=0;
    speakTimer=0;
    
    soundsToPlay.add(youRWearingA);
    soundsToPlay.add(colorSounds[colorIndex]);
    soundsToPlay.add(typeSounds[typeIndex]);
    soundsToPlay.add(a);
    soundsToPlay.add(colorSounds[oppositeColorIndex]);
    soundsToPlay.add(typeSounds[oppositeTypeIndex]);
    soundsToPlay.add(wouldFitYouWayBetter);
  }

  void speak() {
    //Checkt elke keer of de huidige soundfile afgelopen is en de timer ook en speelt dan de track af
    if (currentIndex<soundsToPlay.size()) {
      SoundFile track=soundsToPlay.get(currentIndex);
      if (!track.isPlaying()&&pauseTimer<=0) {
        track.amp(SOUND_AMP);
        track.play();
        println(currentIndex);
        if(currentIndex<6){
        pauseTimer=speakPause[currentIndex]+track.duration();
        }
        currentIndex++;
      }else if(!track.isPlaying()){
      pauseTimer -= 1000 / frameRate;
    }
    }
  }
}

//void recommendColor() {
//  String colorName = colorPicker.getLastColorName();
//  String typeName = typePicker.getLastTypeName();
//  //String colorName = "Blue";
//  //String typeName = "Polo";
//  String oppositeColorName = colorPicker.getLastOppositeColorName();
//  String oppositeTypeName = typePicker.getLastOppositeTypeName();
//  //String oppositeColorName = "Red";
//  //String oppositeTypeName = "Shirt";

//  //below here needs to be a switch statement that decides index of the sound file based on the color name
//  //THESE INDICES SHOULD BE ASSIGNED VIA THE SWITCH STATEMENT!
//  int colorIndex = 0;
//  int typeIndex = 0;
//  int oppositeColorIndex = 0;
//  int oppositeTypeIndex = 0;

//  if (speakTimer <= 0) {
//    isPlaying = false;
//  }

//  if (speakTimer > 0) {
//    speakTimer -= 1000 / frameRate;
//  } else if (pauseCounter < 7) {
//    pauseCounter++;
//    if (pauseCounter < 6) {
//      speakTimer = speakPause[pauseCounter];
//    }
//  }

//  if (!recomHasPlayed && !isPlaying) {
//    println(pauseCounter);
//    switch(pauseCounter) { //determines the length of the next phase 
//    case 0:
//    if(!youRWearingA.isPlaying()){
//      youRWearingA.amp(SOUND_AMP);
//      youRWearingA.play();
//      break;
//    }
//    case 1: 
//      colorSounds[colorIndex].amp(SOUND_AMP);
//      colorSounds[colorIndex].play();

//      break;
//    case 2: 
//      typeSounds[typeIndex].amp(SOUND_AMP);
//      typeSounds[typeIndex].play(); 


//      break;
//    case 3:
//      a.amp(SOUND_AMP);
//      a.play();

//      break;
//    case 4:
//      colorSounds[oppositeColorIndex].amp(SOUND_AMP);
//      colorSounds[oppositeColorIndex].play();


//      break;
//    case 5:
//      typeSounds[oppositeTypeIndex].amp(SOUND_AMP);
//      typeSounds[oppositeTypeIndex].play();



//      break;
//    case 6:
//      wouldFitYouWayBetter.amp(SOUND_AMP);
//      wouldFitYouWayBetter.play();

//      recomHasPlayed=true;
//      break;
//    case 7:
//      recomHasPlayed=false;
//      pauseCounter=0;
//      isPlaying=false;
//      speakTimer=0;
//    }
//  }
//}

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
//}
