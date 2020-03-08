import ddf.minim.*;
import ddf.minim.analysis.*;
import ddf.minim.effects.*;
import ddf.minim.signals.*;
import ddf.minim.spi.*;
import ddf.minim.ugens.*;
import processing.serial.*;


Serial myPort; 

Minim minim;
AudioPlayer speakers;


int currentState = 0;

SoundEffectController SFX;


ArrayList<State> states = new ArrayList<State>();


Gary gary = new Gary();
HeartRate hr = new HeartRate();

//HackerGame game = new HackerGame();
//TTTGame game = new TTTGame();
//BopItGame game = new BopItGame();
//PongGame game = new PongGame();
//GuageGame game = new GuageGame();

PGraphics pg;
PImage console;
int scale = 4;

int screenX = 8;
int screenY = 8;
int screenW = 65;
int screenH = 84;

boolean isUpsideDown = false;
boolean PARTAY = false;
boolean enableSerial = false;

void settings() {
  size(1200, 800);
  fullScreen();
  noSmooth();
}

void setup() {
  
  pg = createGraphics(150, 100, JAVA2D);
  
  noStroke();
  background(163, 172, 136);
  
  hr.setup(87, 67, 54, 19);
  gary.setup(97, 17, 33, 36);
  
  console = loadImage("Plate.png");
  
  
  
  states.add(new DialogState("Hello", false));
  
  states.add(new PongGame());
  states.add(new TTTGame());
  states.add(new BopItGame());
  states.add(new GuageGame());
  //states.add(new GuageGame());
  states.add(new HackerGame());
  states.add(new CarGame());
  
  states.add(new DialogState("YOU WIN", true));
  states.add(new DialogState("YOU LOSE", true));
  //states.add(new DialogState("THE END", true));
  //states.add(new ConfirmState());
  
  for (int i = 0; i < states.size(); i++) {
    states.get(i).executeSetup(screenX, screenY, screenW, screenH);
  }
  
  minim = new Minim (this);
  
  SFX = new SoundEffectController();
  SFX.setup();
  
  gotoState(0);
  
  if (enableSerial)
    myPort = new Serial(this, Serial.list()[0], 9600);
  while (!enableSerial && myPort != null && myPort.available() > 0) {
    myPort.write("HackGT Horizons 2020\n");
  }
}

void draw() {
  while (!enableSerial && myPort != null && myPort.available() > 0) {
    //myPort.write("HackGT Horizons 2020\n");
    String in = myPort.readStringUntil('\n');
    if (in != null && in.trim().length() > 0) {
      println(in.trim());
      keyPressed(in.trim());
    }
  }
  
  blendMode(BLEND);
  
  pg.beginDraw();

  //scale(4);
  pg.background(163, 172, 136);
    
  if (states.get(currentState).shouldShowHeartRate())
    hr.display(pg);
  gary.draw(pg);
  
  states.get(currentState).executeDraw(pg);
  
  if (states.get(currentState).hasStarted()) {
    if (states.get(currentState).win()) {
      gotoState(nextState(currentState, true));
    } else if (states.get(currentState).lose()) {
      gotoState(nextState(currentState, false));
    }
  }

  
  pg.image(console, 0, 0);
  
  pg.endDraw();
  
  
  //heartrate.draw(pg);
  pushMatrix(); 
  
  //if (isUpsideDown) {
  //  println("flippin");
    
  //  translate(10, 10);
  //}
  if (isUpsideDown) {
    scale (-1,-1);
    translate(-width, -height);
    
    
  }
  
  image(pg, 0, 0, width, height);
  popMatrix();
  
  if (PARTAY) {
    blendMode(MULTIPLY);
    //fill(255, 0, 255);
    float t = (float)millis() / 1000;
    fill(noise(t, 0, 0) * 255, noise(0, t, 0) * 255, noise(0, 0, t) * 255);
  
    rect(0, 0, width, height);
  }
}

void keyPressed (String in) {
  
  
  if (in.trim().equals("P0U") || in.trim().equals("P0D")) {
    isUpsideDown = !isUpsideDown;
  }
  
  if (in.trim().equals("L3U")) {
    PARTAY = false;
  }
  
  if (in.trim().equals("L3D")) {
    PARTAY = false;
  }
  
  if (currentState == 0) {
    if (in.trim().equals("M00")) {
      gotoState(0);
    } else if (in.trim().equals("M01")) {
      gotoState(1);
    } else if (in.trim().equals("M02")) {
      gotoState(2);
    } else if (in.trim().equals("M03")) {
      gotoState(3);
    } else if (in.trim().equals("M04")) {
      gotoState(4);
    } else if (in.trim().equals("M05")) {
      gotoState(5);
    } else if (in.trim().equals("M06")) {
      gotoState(6);
    }
  }
  
  if (in.trim().equals("K0H") || in.trim().equals("O0H")) {
    SFX.incrementSoundPackage();
  } else if (in.trim().equals("O1H")){
    SFX.decrementSoundPackage();
  }
  
  OnControlEvent();
  states.get(currentState).keyPressed(in.trim());
  
  if (in.trim().equals("K0H")) {
    gotoState(0);
    return;
  }
}

void keyPressed() {
    if(key == '['){
      SFX.incrementSoundPackage();
    }
    else if(key == ']'){
      SFX.decrementSoundPackage();
    }
    else if(key == '/'){
      println("!!!!");
      isUpsideDown = !isUpsideDown;
    }
    
  if (currentState == 0) {
    if (key == '0') {
      gotoState(0);
    } else if (key == '1') {
      gotoState(1);
    } else if (key == '2') {
      gotoState(2);
    } else if (key == '3') {
      gotoState(3);
    } else if (key == '4') {
      gotoState(4);
    } else if (key == '5') {
      gotoState(5);
    } else if (key == '6') {
      gotoState(6);
    }
  }
  
   OnControlEvent();
   states.get(currentState).keyPressed(key);
   
   if (key == '0') {
    println("BACK");
    gotoState(0);
    return;
  }
}

void OnControlEvent() {
   SFX.playSound();
   if (!states.get(currentState).hasStarted()) {
     states.get(currentState).executeStart();
   }
}


int nextState (int currentState, boolean isWin) {
  //switch (currentState) {
  //  case 0: return isWin ? 1 : 0;
  //  case 1: return isWin ? 2 : 0;
  //  case 2: return isWin ? 3 : 5;
  //  case 3: return isWin ? 4 : 3;
  //  case 4: return isWin ? 5 : 0;
  //  case 5: return isWin ? 6 : 6;  // todo: go to endings
  //  case 6: return isWin ? 0 : 0;  // todo: go to endings
  //}
  
  switch (currentState) {
    case 0: return isWin ? ((int)(random(1, 7))) : 0;
    case 1: return isWin ? 7 : 8;
    case 2: return isWin ? 7 : 8;
    case 3: return isWin ? 7 : 8;
    case 4: return isWin ? 7 : 8;
    case 5: return isWin ? 7 : 8;  
    case 6: return isWin ? 7 : 8;  
    case 7: return isWin ? 0 : 0;  // todo: go to endings
    case 8: return isWin ? 0 : 0;  // todo: go to endings
  }
  return (currentState + 1) % states.size();
}

void gotoState (int state) {
  currentState = state;
  states.get(currentState).executeReset();
  
  //println(states.get(currentState).getHeartRateLevel());
  hr.setLevel(states.get(currentState).getHeartRateLevel());
  // transmit dialog
  //println(states.get(currentState).getDialog());
  
}


char decodeKey(String k) {
  // wasd e
  // ijkl o
  
  
  
  if (k.equals("I0H")) return 'e';
  if (k.equals("H0L")) return 'w';
  if (k.equals("H0R")) return 's';
  if (k.equals("H2L")) return 'i';
  if (k.equals("H2R")) return 'k';
  if (k.equals("H2L")) return 'k';
  if (k.equals("H2R")) return 'i';
  return '0';
}
