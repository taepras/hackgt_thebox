public class SoundEffectController{
  
  ArrayList<SoundData> soundPackages;
  
  int state;
  
  public void setState(){
  }
  
  public void playSound(){
  
    int soundIdx = int(random(soundPackages.get(state).sounds.size()));
    AudioPlayer sound = soundPackages.get(state).sounds.get(soundIdx);
    sound.rewind();
    sound.play();
  }
  
  public void setup(){
    soundPackages = new ArrayList<SoundData>();
    
    String [] beepFiles = new String[] {"sounds/blip_A.wav", "sounds/blip_B.wav", "sounds/blip_C.wav"};
    soundPackages.add(new SoundData(beepFiles, 3));
    
    String [] bellFiles = new String[] {"sounds/bell_A.wav", "sounds/bell_B.wav", "sounds/bell_C.wav"};
    soundPackages.add(new SoundData(bellFiles, 3));
    
    String [] dumbFiles = new String[] {"sounds/dumb_A.wav", "sounds/dumb_B.wav"};
    soundPackages.add(new SoundData(dumbFiles, 2));
    
    String [] barkFiles = new String[] {"sounds/bark_A.wav", "sounds/bark_B.wav", "sounds/bark_C.wav"};
    soundPackages.add(new SoundData(barkFiles, 3));
    
    
    
  }
  
  public void incrementSoundPackage(){
   state = (state + 1) % soundPackages.size(); 
  }
  
  public void decrementSoundPackage(){
   state = (state - 1 + soundPackages.size()) % soundPackages.size(); 
  }
  
  class SoundData{
    
    ArrayList<AudioPlayer> sounds;
    
    public SoundData(String[] fileNames, int count){
      
      sounds = new ArrayList<AudioPlayer>();
      for(int i = 0; i < count; i++) sounds.add(minim.loadFile(fileNames[i]));
    }

  };
  
};
