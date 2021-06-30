//// Have Fun & Play Project
//// Style Eyes Speech Synthesizer
//// By Jelle Gerritsen and Ysbrand Burgstede

import java.util.Iterator;

class SpeechSynth {

  static final int MAX_PAUSE_AMOUNT = 6;
  static final float SOUND_AMP = 0.1;

  HashMap<String, SoundFile> soundLookUp = new HashMap<String, SoundFile>();

  float[] speakPause =  {0.1, 0.1, 0.1, 0.1, 0.1, 1, 0.1, 0.1, 0.1, 0.1}; //speakpause array that gives the pause time in seconds

  SoundFile youRWearingA;
  SoundFile a;
  SoundFile wouldFitYouWayBetter;
  SoundFile iThinkYouKnow;
  SoundFile andThisIsExactlyWhyA;
  SoundFile isAThousandTimesBetter; 

  ArrayList <SoundFile> soundsToPlay;
  int currentIndex=0;
  float pauseTimer;

  Delay roboDelay;
  ColorPicker colorPicker;
  TypePicker typePicker;

  SoundFile nowPlaying;

  SpeechSynth(ColorPicker colorPicker, TypePicker typePicker) {

    soundsToPlay=new ArrayList<SoundFile>(); //creates an array which is filled with all sounds that should be played

    //initialize the robotical delay
    roboDelay = new Delay(HFP_Advertisement_Interface.this); 
    roboDelay.set(0.018, 0.55);

    //initialize all standard audio samples
    youRWearingA = new SoundFile(HFP_Advertisement_Interface.this, "wav/youarewearinga.wav");
    //sounds.add(youRWearingA);
    a = new SoundFile(HFP_Advertisement_Interface.this, "wav/A.wav");
    wouldFitYouWayBetter = new SoundFile(HFP_Advertisement_Interface.this, "wav/wouldfityouwaybetter.wav");
    iThinkYouKnow = new SoundFile(HFP_Advertisement_Interface.this, "wav/ithinkyouknow.wav");
    andThisIsExactlyWhyA =  new SoundFile(HFP_Advertisement_Interface.this, "wav/andthisisexactlywhya.wav");
    isAThousandTimesBetter =  new SoundFile(HFP_Advertisement_Interface.this, "wav/isathousandtimesbetter.wav");    
    nowPlaying = a;

    //initialize all interchangable samples
    String path=sketchPath()+"\\wav";
    java.io.File folder = new java.io.File(path);
    String [] fileNames=folder.list();
    for (String fileName : fileNames) {
      if (fileName.contains(".wav")) {
        String name=fileName.substring(0, fileName.lastIndexOf('.'));
        String myPath=path+'\\'+fileName;
        //println(myPath);
        SoundFile thisAudioFile= new SoundFile(HFP_Advertisement_Interface.this, myPath);
        thisAudioFile.amp(SOUND_AMP);
        roboDelay.process(thisAudioFile, 0.018);
        soundLookUp.put(name, thisAudioFile);
        //sounds.add(thisAudioFile);
      }
    }

    //initialize clothing pickers
    this.colorPicker = colorPicker;
    this.typePicker = typePicker;
  }

  void init() {    
    //WORDT 1X PER SEQUENCE UITGEVOERD!
    String colorName = colorPicker.getLastColorName();
    String typeName = typePicker.getLastTypeName();
    String oppositeColorName = colorPicker.getLastOppositeColorName();
    String oppositeTypeName = typePicker.getLastOppositeTypeName();

    //get all correct sounds from the hashmap
    SoundFile colorAudio=soundLookUp.get(colorName);
    SoundFile typeAudio=soundLookUp.get(typeName);
    SoundFile oppositeAudio=soundLookUp.get(oppositeColorName);
    SoundFile oppositeTypeAudio=soundLookUp.get(oppositeTypeName);
    soundsToPlay=new ArrayList<SoundFile>();
    currentIndex=0;

    //add all correct samples to the soundToPlay arrayList
    soundsToPlay.add(youRWearingA);
    if (colorAudio!=null) soundsToPlay.add(colorAudio);
    else println("Couldn't find the audio for: "+colorName);

    if (typeAudio!=null) soundsToPlay.add(typeAudio);
    else println("Couldn't find the audio for: "+typeName);

    soundsToPlay.add(a);
    if (oppositeAudio!=null) soundsToPlay.add(oppositeAudio);
    else println("Couldn't find the audio for: "+oppositeColorName);

    if (oppositeTypeAudio!=null) soundsToPlay.add(oppositeTypeAudio); 
    else println("Couldn't find the audio for: "+oppositeTypeName);

    soundsToPlay.add(wouldFitYouWayBetter);

    soundsToPlay.add(andThisIsExactlyWhyA);
    if (oppositeAudio!=null) soundsToPlay.add(oppositeAudio);
    else println("Couldn't find the audio for: "+oppositeColorName);

    if (oppositeTypeAudio!=null) soundsToPlay.add(oppositeTypeAudio); 
    else println("Couldn't find the audio for: "+oppositeTypeName);

    soundsToPlay.add(isAThousandTimesBetter);
    soundsToPlay.add(iThinkYouKnow);
  }

  //plays all samples in the correct order from the soundsToPlay arrayList
  void speak() {
    //Checkt elke keer of de huidige soundfile afgelopen is en de timer ook en speelt dan de track af
    if (currentIndex<soundsToPlay.size()) {
      try {
        SoundFile track = soundsToPlay.get(currentIndex);
        if (!nowPlaying.isPlaying() && pauseTimer <= 0) {
          track.play();
          nowPlaying = track;
          if (currentIndex<10) {
            pauseTimer=speakPause[currentIndex]+track.duration();
          }
          currentIndex++;
        }
        pauseTimer -= 1 / frameRate; //update the pausetimer so that the next sample is played when the pause is done
      }
      catch(Exception e) {
        println("Something went wrong with the sound! playing next track"+e);
        currentIndex++;
      }
    }
  }
}
