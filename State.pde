public class State {
  boolean hasStarted;
  int screenWidth, screenHeight, screenX, screenY;
  
  int stateEnteredTime;
  int safeTimeout = 1500;
    
  public void executeSetup(int screenX, int screenY, int screenWidth, int screenHeight) {
    this.screenX = screenX;
    this.screenY = screenY;
    this.screenWidth = screenWidth;
    this.screenHeight = screenHeight;
    setup();
  }
  
  public void setup() {}
  public void executeReset() { 
    hasStarted = false;
    stateEnteredTime = millis();
    reset();
  }  
  
  public void reset() {}
  
  public void executeDraw(PGraphics pg) {
    if (hasStarted || !needStart()) {
      draw(pg);
    } else {
      pg.textSize(9);
      pg.textAlign(CENTER, CENTER);
      pg.fill(93, 98, 78);
      
      pg.text("Get Ready" + (millis() - stateEnteredTime > safeTimeout ? "\nbop to start" : ""), screenX + screenWidth / 2, screenY + screenHeight / 2);
    }
  }
  
  public void draw(PGraphics pg) {}
  public void keyPressed(char k) {}
  public void keyPressed(String s) {}
  public boolean win() { return true; }
  public boolean lose() { return false; }
  public boolean shouldShowHeartRate() { return false; }
  public boolean hasStarted() { return hasStarted; }
  
  public void start() {}
  public void executeStart() {
    if (millis() - stateEnteredTime < safeTimeout && needStart())
      return;
    start();
    hasStarted = true; 
  }
  public String getDialog() { return "hello"; }
  public int getHeartRateLevel() { return 1; }
  public boolean needStart() { return true; }
}
