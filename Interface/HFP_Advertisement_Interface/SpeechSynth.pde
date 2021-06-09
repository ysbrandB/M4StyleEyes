//// Have Fun & Play Project
//// Style Eyes Speech Synthesizer
//// By Jelle Gerritsen

class SpeechSynth {

  static final int COLOR_AMOUNT = 9;
  static final int TYPE_AMOUNT = 5;
  static final int MAX_PAUSE_AMOUNT = 6;
  static final float SOUND_AMP = 0.1;

  Boolean recomHasPlayed = false;
  boolean isPlaying = false;

  int speakTimer;
  int pauseCounter = 0;

  int [] speakPause = {1200, 600, 1400, 600, 500, 800};

  SoundFile youRWearingA;
  SoundFile[] colorSounds = new SoundFile[COLOR_AMOUNT];
  SoundFile[] typeSounds = new SoundFile[TYPE_AMOUNT];
  SoundFile a;
  SoundFile wouldFitYouWayBetter;

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

  void recommendColor() {
    String colorName = colorPicker.getLastColorName();
    String typeName = typePicker.getLastTypeName();
    //String colorName = "Blue";
    //String typeName = "Polo";
    String oppositeColorName = colorPicker.getLastOppositeColorName();
    String oppositeTypeName = typePicker.getLastOppositeTypeName();
    //String oppositeColorName = "Red";
    //String oppositeTypeName = "Shirt";

    //below here needs to be a switch statement that decides index of the sound file based on the color name
    //THESE INDICES SHOULD BE ASSIGNED VIA THE SWITCH STATEMENT!
    int colorIndex = 0;
    int typeIndex = 0;
    int oppositeColorIndex = 0;
    int oppositeTypeIndex = 0;

    if (speakTimer <= 0) {
      isPlaying = false;
    }

    if (speakTimer > 0) {
      speakTimer -= 1000 / frameRate;
    } else if (pauseCounter < 7) {
      pauseCounter++;
      if(pauseCounter < 6){
      speakTimer = speakPause[pauseCounter];
      }
    }

    if (!recomHasPlayed && !isPlaying) {
      println(pauseCounter);
      switch(pauseCounter) { //determines the length of the next phase 
      case 0:
        youRWearingA.amp(SOUND_AMP);
        youRWearingA.play();
        isPlaying=true;
        break;
      case 1: 
        colorSounds[colorIndex].amp(SOUND_AMP);
        colorSounds[colorIndex].play();
        isPlaying=true;
        break;
      case 2: 
        typeSounds[typeIndex].amp(SOUND_AMP);
        typeSounds[typeIndex].play(); 
        isPlaying=true;
        break;
      case 3:
        a.amp(SOUND_AMP);
        a.play();
        isPlaying=true;
        break;
      case 4:
        colorSounds[oppositeColorIndex].amp(SOUND_AMP);
        colorSounds[oppositeColorIndex].play();
        isPlaying=true;
        break;
      case 5:
        typeSounds[oppositeTypeIndex].amp(SOUND_AMP);
        typeSounds[oppositeTypeIndex].play();
        isPlaying=true;
        break;
      case 6:
        wouldFitYouWayBetter.amp(SOUND_AMP);
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
