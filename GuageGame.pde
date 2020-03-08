public class GuageGame extends State {
    
  IntList guageLevel = new IntList();
  IntList guageTickInterval = new IntList();
  IntList guageLastTick = new IntList();
  IntList guageStep = new IntList();
  IntList guageDecay = new IntList();
  IntList guageMax = new IntList();
  IntList guageGoalMin = new IntList();
  IntList guageGoalMax = new IntList();
  
  PGraphics pg;
  
  int goodStartTime;
  boolean timerOn;
  
  int winTime = 5000;
  
  public void start () {
    
    guageLevel.clear();
    guageLevel.append(0);
    guageLevel.append(0);
    guageLevel.append(0);
    
    guageStep.clear();
    guageStep.append(7);
    guageStep.append(4);
    guageStep.append(6);
    
    guageTickInterval.clear();
    guageTickInterval.append(100);
    guageTickInterval.append(200);
    guageTickInterval.append(170);

    guageLastTick.clear();
    guageLastTick.append(0);
    guageLastTick.append(0);
    guageLastTick.append(0);
    
    guageDecay.clear();
    guageDecay.append(1);
    guageDecay.append(1);
    guageDecay.append(1);
    
    guageMax.clear();
    guageMax.append(60);
    guageMax.append(60);
    guageMax.append(60);
    
    guageGoalMin.clear();
    guageGoalMax.clear();
    
    guageGoalMin.append(26);
    guageGoalMax.append(55);
    
    guageGoalMin.append(20);
    guageGoalMax.append(37);
    
    guageGoalMin.append(43);
    guageGoalMax.append(57);
    
    goodStartTime = millis();
  }
  
  public void  draw(PGraphics pg) {
    int t = millis();
    for (int i = 0; i < guageLevel.size(); i++) {
      if (t - guageLastTick.get(i) > guageTickInterval.get(i)) {
        guageLevel.set(i, constrain(guageLevel.get(i) - guageDecay.get(i), 0, guageMax.get(i)));
        guageLastTick.set(i, t);
      }
    }
    
    int barWidth = 7;
    int barGutter = 14;
    int paddingTop = 19;
    int paddingLeft = 2;
    int tickLength = 4;
    
    
    for (int i = 0; i < guageLevel.size(); i++) {
      int x = screenX + paddingLeft + screenX + barWidth * i + barGutter * i;
      int y = screenY + paddingTop;
      
      pg.noFill();
      pg.stroke(39, 41, 32);
      pg.rect(x, y, barWidth, guageMax.get(i));
      
      if (guageGoalMin.get(i) <= guageLevel.get(i) && guageLevel.get(i) <= guageGoalMax.get(i)) {
        pg.fill(93, 98, 78);
      } else {
        pg.fill(39, 41, 32);
      }
      
      pg.rect(x, y + guageMax.get(i) - guageLevel.get(i), barWidth, guageLevel.get(i));
      
      pg.stroke(93, 98, 78);
      pg.line(x - 2, y + guageMax.get(i) - guageGoalMin.get(i), x - 2 - tickLength, y + guageMax.get(i) - guageGoalMin.get(i));
      pg.line(x - 2, y + guageMax.get(i) - guageGoalMax.get(i), x - 2 - tickLength, y + guageMax.get(i) - guageGoalMax.get(i));
      pg.line(x - 2 - tickLength / 2, y + guageMax.get(i) - guageGoalMin.get(i), x - 2 - tickLength / 2, y + guageMax.get(i) - guageGoalMax.get(i));
    }
    
    int goodCount = 0; 
    for (int i = 0; i < guageLevel.size(); i++) {
      if (guageGoalMin.get(i) <= guageLevel.get(i) && guageLevel.get(i) <= guageGoalMax.get(i)) {
        goodCount++;
      }
    }
    
    if (goodCount == guageLevel.size()) {
      if (!timerOn) {
        goodStartTime = t;
        timerOn = true;
      }
    } else {
      timerOn = false;
    }
    
    if (t - goodStartTime >= winTime) {
      // win();
    }
    
    pg.textSize(9);
    pg.textAlign(CENTER);
    
    pg.fill(93, 98, 78);
    if (!timerOn) {
      if (goodCount == 0)
        pg.text(":(", screenX + screenWidth / 2, 20);
      else if (goodCount == 1)
        pg.text(":|", screenX + screenWidth / 2, 20);
      else if (goodCount == 2)
        pg.text(":o", screenX + screenWidth / 2, 20);
    } else {
      pg.text(nf((float)(winTime - (t - goodStartTime)) / 1000, 0, 1), screenX + screenWidth / 2, 20);
    }
  }
  
  public void keyPressed(char k) {
    if (k == 'q') {
      guageLevel.set(0, constrain(guageLevel.get(0) + guageStep.get(0), 0, guageMax.get(0)));
    } else if (k == 'w') {
      guageLevel.set(1, constrain(guageLevel.get(1) + guageStep.get(1), 0, guageMax.get(1)));
    } else if (k == 'e') {
      guageLevel.set(2, constrain(guageLevel.get(2) + guageStep.get(2), 0, guageMax.get(2)));
    }
  }
  
  public void keyPressed(String s) {
    if (s.charAt(1) == '0') {
      guageLevel.set(0, constrain(guageLevel.get(0) + guageStep.get(0), 0, guageMax.get(0)));
    } else if (s.charAt(1) == '1') {
      guageLevel.set(1, constrain(guageLevel.get(1) + guageStep.get(1), 0, guageMax.get(1)));
    } else if (s.charAt(1) == '2' || s.charAt(1) == '3') {
      guageLevel.set(2, constrain(guageLevel.get(2) + guageStep.get(2), 0, guageMax.get(2)));
    }
  }
  
  public boolean win() {
    return timerOn && millis() - goodStartTime >= winTime;
  }
  
  public boolean lose() {
    return false;
  }
  
  public boolean shouldShowHeartRate() { return true; }
  public int getHeartRateLevel() { return 3; }
}
