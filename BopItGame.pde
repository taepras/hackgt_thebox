public class BopItGame extends State{
  
  int maxMisses = 5;
  //int maxMisses = 3;
  int commandTimeout = 2000;
  int minCommandTime = 300;
  
  int lastCommandTime = 0;
  
  StringList possibleActions;
  String currentAction;
  int misses = 0;
  
  
  int goodCount;
  int winGoodCount = 5;
  
  
  public void setup () {
    
    int t = millis();
    lastCommandTime = t;
    
    possibleActions = new StringList();
    possibleActions.append("bop");
    possibleActions.append("twist");
    possibleActions.append("pull");
    //possibleActions.append("push");
    //possibleActions.append("slide");
    
    nextAction();
    //possibleActions.append("slide");
  }
  
  public void reset() {
    misses = 0;
    goodCount = 0;
  }
  
  public void start() {
    lastCommandTime = millis();
    misses = 0;
    goodCount = 0;
    nextAction();
  }

  
  public void  draw(PGraphics pg) {
    int t = millis();
    if (t - lastCommandTime > commandTimeout) {
      nextAction();
      lastCommandTime = t;
      misses++;
    }
    
    int paddingX = 10;
    int paddingY = 10;
    int barWidth = screenWidth - 2 * paddingX;
    int barHeight = 3;
    
    pg.noFill();
    pg.stroke(39, 41, 32);
    pg.rect(screenX + paddingX, screenY + paddingY, barWidth, barHeight);
    
    pg.fill(39, 41, 32);
    
    float timeLeftRatio = 1 - (float)(t - lastCommandTime) / commandTimeout;
    pg.rect(screenX + paddingX + barWidth * (1 - timeLeftRatio), screenY + paddingY, barWidth * timeLeftRatio, barHeight);
  
    pg.textSize(9);
    pg.textAlign(CENTER);
    pg.fill(93, 98, 78);
    
    pg.text(currentAction + " it.", screenX + screenWidth / 2, screenY + screenHeight / 2);
    
    String missStringBg = "";
    for (int i = 0; i < maxMisses; i++) {
      missStringBg += ":( ";
    }
    
    String missString = "";
    for (int i = 0; i < misses; i++) {
      missString += ":( ";
    }
    
    pg.textAlign(LEFT);
    pg.fill(141, 148, 121);
    pg.text(missStringBg, screenX + paddingX, screenY + screenHeight - paddingY);
    pg.fill(39, 41, 32);
    pg.text(missString, screenX + paddingX, screenY + screenHeight - paddingY);
    
    
    String goodStringBg = "";
    for (int i = 0; i < winGoodCount; i++) {
      goodStringBg += ":) ";
    }
    
    String goodString = "";
    for (int i = 0; i < goodCount; i++) {
      goodString += ":) ";
    }
    
    pg.textAlign(LEFT);
    pg.fill(141, 148, 121);
    pg.text(goodStringBg, screenX + paddingX, screenY + screenHeight - paddingY - 10);
    pg.fill(39, 41, 32);
    pg.text(goodString, screenX + paddingX, screenY + screenHeight - paddingY - 10);
  }
  
  private void nextAction () {
    int t = millis();
    lastCommandTime = t;
    int index = (int)random(0, possibleActions.size());
    
    currentAction = possibleActions.get(index);
  }
  
  private void doAction(String action) {
    if (millis() - lastCommandTime < minCommandTime)
      return;
      
    if (action.equals(currentAction)) {
      nextAction();
      goodCount++;
    } else {
      nextAction();
      misses++;
    }
  }
  
  public void keyPressed(char k) {
    if (k == 'q') {
      doAction("bop");
    } else if (k == 'w') {
      doAction("twist");
    } else if (k == 'e') {
      doAction("pull");
    } else if (k == 'r') {
      doAction("push");
    } else if (k == 't') {
      doAction("slide");
    }
  }
  
  public void keyPressed(String s) {
    if (s.charAt(0) == 'E' || s.charAt(0) == 'J') {
      doAction("pull");
    } else if (s.charAt(0) == 'H') {
      doAction("twist");
    } else if (s.charAt(0) == 'D' || s.charAt(2) == 'H' || s.charAt(0) == 'F' || s.charAt(0) == 'G' || s.charAt(0) == 'I' || s.charAt(0) == 'K' || s.charAt(0) == 'L' || s.charAt(0) == 'M' || s.charAt(0) == 'O') {
      doAction("bop");
    } else if (s.charAt(0) == 'P') {
      doAction("flick");
    }
  }
  
  public boolean win() {
    return goodCount >= winGoodCount;
  }
  
  public boolean lose() {
    return misses > maxMisses;
  }
  
  public boolean shouldShowHeartRate() { return true; }
  public int getHeartRateLevel() { return 2; }
}
