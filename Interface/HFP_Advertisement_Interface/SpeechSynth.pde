//// Have Fun & Play Project
//// Style Eyes Speech Synthesizer
//// By Jelle Gerritsen and Ysbrand Burgstede

class SpeechSynth {

  static final int MAX_PAUSE_AMOUNT = 6;
  static final float SOUND_AMP = 0.1;

  HashMap<String, SoundFile> soundLookUp = new HashMap<String, SoundFile>();

  float [] speakPause =  {0.3, 0.3, 0.3, 0.3, 0.3, 0.3};

  SoundFile youRWearingA;
  SoundFile a;
  SoundFile wouldFitYouWayBetter;

  ArrayList <SoundFile> soundsToPlay;
  int currentIndex=0;
  float pauseTimer;

  Delay roboDelay;
  ColorPicker colorPicker;
  TypePicker typePicker;

  SpeechSynth(ColorPicker colorPicker, TypePicker typePicker) {
    soundsToPlay=new ArrayList<SoundFile>();
    roboDelay = new Delay(HFP_Advertisement_Interface.this);

    youRWearingA = new SoundFile(HFP_Advertisement_Interface.this, "wav/youarewearinga.wav");
    a = new SoundFile(HFP_Advertisement_Interface.this, "wav/A.wav");
    wouldFitYouWayBetter = new SoundFile(HFP_Advertisement_Interface.this, "wav/wouldfityouwaybetter.wav");

    roboDelay.process(youRWearingA, 0.04);
    roboDelay.process(a, 0.04);
    roboDelay.process(wouldFitYouWayBetter, 0.04);

    String path=sketchPath()+"\\wav";
    java.io.File folder = new java.io.File(path);
    String [] fileNames=folder.list();
    printArray(fileNames);
    for (String fileName : fileNames) {
      println(fileName);
      if (fileName.contains(".wav")) {
        String name=fileName.substring(0, fileName.lastIndexOf('.'));
        String myPath=path+'\\'+fileName;
        println(myPath);
        SoundFile thisAudioFile= new SoundFile(HFP_Advertisement_Interface.this, myPath);
        soundLookUp.put(name, thisAudioFile);
      }
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
    
    SoundFile colorAudio=soundLookUp.get(colorName);
    SoundFile typeAudio=soundLookUp.get(typeName);
    SoundFile oppositeAudio=soundLookUp.get(oppositeColorName);
    SoundFile oppositeTypeAudio=soundLookUp.get(oppositeTypeName);
    soundsToPlay=new ArrayList<SoundFile>();
    currentIndex=0;

    soundsToPlay.add(youRWearingA);
    if (colorAudio!=null) {
      soundsToPlay.add(colorAudio);
    } else {
      println("Couldn't find the audio for: "+colorName);
    }
    if (typeAudio!=null) {
      soundsToPlay.add(typeAudio);
    } else {
      println("Couldn't find the audio for: "+typeName);
    }
    soundsToPlay.add(a);
    if (oppositeAudio!=null) {
      soundsToPlay.add(oppositeAudio);
    } else {
      println("Couldn't find the audio for: "+oppositeColorName);
    }
    if (oppositeTypeAudio!=null) {
      soundsToPlay.add(oppositeTypeAudio);
    } else {
      println("Couldn't find the audio for: "+oppositeTypeName);
    }
    soundsToPlay.add(wouldFitYouWayBetter);
  }

  void speak() {
    //Checkt elke keer of de huidige soundfile afgelopen is en de timer ook en speelt dan de track af
    if (currentIndex<soundsToPlay.size()) {
      try {
        SoundFile track=soundsToPlay.get(currentIndex);
        if (!track.isPlaying()&&pauseTimer<=0) {
          track.amp(SOUND_AMP);
          track.play();
          if (currentIndex<6) {
            pauseTimer=speakPause[currentIndex]+track.duration();
          }
          currentIndex++;
        }
        pauseTimer -= 1 / frameRate;
      }
      catch(Exception e) {
        println("Something went wrong with the sound! playing next track"+e);
        currentIndex++;
      }
    }
  }
}
