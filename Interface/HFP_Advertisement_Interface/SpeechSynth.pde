//// Have Fun & Play Project
//// Style Eyes Speech Synthesizer
//// By Jelle Gerritsen and Ysbrand Burgstede

import java.util.Iterator;

class SpeechSynth {

  static final int MAX_PAUSE_AMOUNT = 6;
  static final float SOUND_AMP = 0.1;

  HashMap<String, SoundFile> soundLookUp = new HashMap<String, SoundFile>();
  ArrayList<SoundFile> sounds = new ArrayList<SoundFile>();

   float[] speakPause =  {0.1, 0.1, 0.1, 0.1, 0.1, 0.1}; //speakpause array that gives the pause time in seconds

  SoundFile youRWearingA;
  SoundFile a;
  SoundFile wouldFitYouWayBetter;

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
    sounds.add(youRWearingA);
    a = new SoundFile(HFP_Advertisement_Interface.this, "wav/A.wav");
    sounds.add(a);
    wouldFitYouWayBetter = new SoundFile(HFP_Advertisement_Interface.this, "wav/wouldfityouwaybetter.wav");
    sounds.add(wouldFitYouWayBetter);

    nowPlaying = a;
    
    //initialize all interchangable samples
    String path=sketchPath()+"\\wav";
    java.io.File folder = new java.io.File(path);
    String [] fileNames=folder.list();
    printArray(fileNames);
    for (String fileName : fileNames) {
      println(fileName);
      if (fileName.contains(".wav")) {
        String name=fileName.substring(0, fileName.lastIndexOf('.'));
        String myPath=path+'\\'+fileName;
        //println(myPath);
        SoundFile thisAudioFile= new SoundFile(HFP_Advertisement_Interface.this, myPath);
        soundLookUp.put(name, thisAudioFile);
        sounds.add(thisAudioFile);
      }
    }

    for(SoundFile sound : sounds) {      
      sound.amp(SOUND_AMP);
      roboDelay.process(sound, 0.018);
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

  //plays all samples in the correct order from the soundsToPlay arrayList
  void speak() {
    //Checkt elke keer of de huidige soundfile afgelopen is en de timer ook en speelt dan de track af
    if (currentIndex<soundsToPlay.size()) {
      try {
        SoundFile track = soundsToPlay.get(currentIndex);
        if (!nowPlaying.isPlaying()) {
          track.play();
          nowPlaying = track;
          if (currentIndex<6) {
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
