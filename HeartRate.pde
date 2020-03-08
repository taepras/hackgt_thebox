public class HeartRate {
  
  int _x; 
  int _y;
  int _width;
  int _height;
  
  int pulsePos;
  int pulseSpeed = 1;
  int numPulses = 1;
  
  
  PImage line;
  PImage pulse;
  
  boolean isDead = false;
  AudioPlayer ekgSound; 
  
  
  public void setup(int x, int y, int HRwidth, int HRheight){
    _x = x;
    _y = y;
    _width = HRwidth;
    _height = HRheight;
    
    line = loadImage("Baseline.png");
    pulse = loadImage("Pulse.png");
    
    pulsePos = HRwidth;
    //ekgSound = minim.loadFile("sounds/ekg.wav");
  }
  
  public void display(PGraphics pg){
    pg.pushMatrix();
      pg.translate(_x, _y);
      
      int totalLength = _width + 2*pulse.width;
      
      //pg.fill(39, 41, 32);
      pg.fill(163, 172, 136);
      pg.noStroke();
      pg.rect(-pulse.width, 0, totalLength, _height);
      pg.image(line, 0, _height/2);
      
      pulsePos -= pulseSpeed;
      if(pulsePos <= -pulse.width){
        resetPulse();
      }
      
      if(numPulses > 0){
        int offset = (pulse.width + _width) / numPulses;
        
        //if(offset
        
        for(int i = 0; i < numPulses; i++){
          
          int relPos = pulsePos + i * offset;
          if(relPos >= _width){
            relPos -= _width + pulse.width;
          }
          
          pg.image(pulse, relPos, 0);
        }
      }
      
      pg.rect(-pulse.width, 0, pulse.width, pulse.height);
      pg.rect(_width, 0, pulse.width, pulse.height);
    pg.popMatrix();
  }
  
  public void resetPulse(){
    pulsePos = _width;
    //TODO: Beep?
  }
  
  public void setPulseSpeed(int speed){
    println(speed);
    pulseSpeed = speed;
  }
  
  public void setNumPulses(int num){
    println(num);
    numPulses = num;
  }
  
  public void setLevel(int x) {
    switch (x) {
      case 0: setPulseSpeed(0); setNumPulses(0); break;
      case 1: setPulseSpeed(1); setNumPulses(1); break;
      case 2: setPulseSpeed(2); setNumPulses(1); break;
      case 3: setPulseSpeed(2); setNumPulses(2); break;
      case 4: setPulseSpeed(3); setNumPulses(2); break;
      case 5: setPulseSpeed(4); setNumPulses(2); break;
    }
  }
};
