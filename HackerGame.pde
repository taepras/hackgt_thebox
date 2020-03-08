public class HackerGame extends State {
  
  String fullCode = ""
    + "public class BopItGame {\n"
    + "  \n"
    + "  int screenWidth, screenHeight, screenX, screenY;\n"
    + "  \n"
    + "  int maxMisses = 3;\n"
    + "  //int maxMisses = 3;\n"
    + "  int commandTimeout = 1500;\n"
    + "  \n"
    + "  int lastCommandTime = 0;\n"
    + "  \n"
    + "  StringList possibleActions;\n"
    + "  String currentAction;\n"
    + "  int misses = 0;\n"
    + "  \n"
    + "  int command = 0;\n"
    + "  \n"
    + "  int goodCount;\n"
    + "  int winGoodCount = 8;\n"
    + "  \n"
    + "  \n"
    + "  public void setup (int screenX, int screenY, int screenWidth, int screenHeight) {\n"
    + "    this.screenX = screenX;\n"
    + "    this.screenY = screenY;\n"
    + "    this.screenWidth = screenWidth;\n"
    + "    this.screenHeight = screenHeight;\n"
    + "    \n"
    + "    \n"
    + "    int t = millis();\n"
    + "    lastCommandTime = t;\n"
    + "    \n"
    + "    possibleActions = new StringList();\n"
    + "    possibleActions.append(\"bop\");\n"
    + "    possibleActions.append(\"twist\");\n"
    + "    possibleActions.append(\"pull\");\n"
    + "    possibleActions.append(\"push\");\n"
    + "    possibleActions.append(\"slide\");\n"
    + "    \n"
    + "    nextAction();\n"
    + "    //possibleActions.append(\"slide\");\n"
    + "  }\n"
    + "  \n"
    + "  public void  draw(PGraphics pg) {\n"
    + "    int t = millis();\n"
    + "    if (t - lastCommandTime > commandTimeout) {\n"
    + "      nextAction();\n"
    + "      lastCommandTime = t;\n"
    + "      misses++;\n"
    + "    }\n"
    + "    \n"
    + "    int paddingX = 10;\n"
    + "    int paddingY = 10;\n"
    + "    int barWidth = screenWidth - 2 * paddingX;\n"
    + "    int barHeight = 3;\n"
    + "    \n"
    + "    pg.noFill();\n"
    + "    pg.stroke(39, 41, 32);\n"
    + "    pg.rect(screenX + paddingX, screenY + paddingY, barWidth, barHeight);\n"
    + "    \n"
    + "    pg.fill(39, 41, 32);\n"
    + "    \n"
    + "    float timeLeftRatio = 1 - (float)(t - lastCommandTime) / commandTimeout;\n"
    + "    pg.rect(screenX + paddingX + barWidth * (1 - timeLeftRatio), screenY + paddingY, barWidth * timeLeftRatio, barHeight);\n"
    + "  \n"
    + "    pg.textSize(9);\n"
    + "    pg.textAlign(CENTER);\n"
    + "    pg.fill(93, 98, 78);\n"
    + "    \n"
    + "    pg.text(currentAction + \" it.\", screenX + screenWidth / 2, screenY + screenHeight / 2);\n"
    + "    \n"
    + "    String missStringBg = \"\";\n"
    + "    for (int i = 0; i < maxMisses; i++) {\n"
    + "      missStringBg += \":( \";\n"
    + "    }\n"
    + "    \n"
    + "    String missString = \"\";\n"
    + "    for (int i = 0; i < misses; i++) {\n"
    + "      missString += \":( \";\n"
    + "    }\n"
    + "    \n"
    + "    pg.textAlign(LEFT);\n"
    + "    pg.fill(180, 180, 180);\n"
    + "    pg.text(missStringBg, screenX + paddingX, screenY + screenHeight - paddingY);\n"
    + "    pg.fill(39, 41, 32);\n"
    + "    pg.text(missString, screenX + paddingX, screenY + screenHeight - paddingY);\n"
    + "    \n"
    + "    \n"
    + "    String goodStringBg = \"\";\n"
    + "    for (int i = 0; i < winGoodCount; i++) {\n"
    + "      goodStringBg += \":) \";\n"
    + "    }\n"
    + "    \n"
    + "    String goodString = \"\";\n"
    + "    for (int i = 0; i < goodCount; i++) {\n"
    + "      goodString += \":) \";\n"
    + "    }\n"
    + "    \n"
    + "    pg.textAlign(LEFT);\n"
    + "    pg.fill(180, 180, 180);\n"
    + "    pg.text(goodStringBg, screenX + paddingX, screenY + screenHeight - paddingY - 10);\n"
    + "    pg.fill(39, 41, 32);\n"
    + "    pg.text(goodString, screenX + paddingX, screenY + screenHeight - paddingY - 10);\n"
    + "  }\n"
    + "  \n"
    + "  private void nextAction () {\n"
    + "    int t = millis();\n"
    + "    lastCommandTime = t;\n"
    + "    int index = (int)random(0, possibleActions.size());\n"
    + "    \n"
    + "    currentAction = possibleActions.get(index);\n"
    + "  }\n"
    + "  \n"
    + "}\n";
      
  int progress = 0;
  int step = 20;
  
  int startTime = 0;
  int maxTime = 30000;
  
  PGraphics pg;
  
  public void setup () {
    
    
  }
  
  public void reset() {
    progress = 0;
  }
  
  public void start() {
    progress = 0;
    startTime = millis();
  }
  
  public void  draw(PGraphics pg) {
    int t = millis();
    
    String typed = fullCode.substring(0, Math.min(progress, fullCode.length()));
    pg.textSize(8);
    pg.textAlign(LEFT, TOP);
    pg.textLeading(8);
    
    pg.fill(93, 98, 78);
    
    pg.text(typed, 10, 10 + Math.max(0, (countLines(typed) - 10)) * -8);
    
    
    pg.fill(39, 41, 32);
    pg.textSize(9);
    pg.textAlign(CENTER, CENTER);
    pg.text("HACK THIS.", screenX + screenWidth / 2, screenY + screenHeight / 2 - 10);
    
    int paddingX = 10;
    int paddingY = 10;
    int barWidth = screenWidth - 2 * paddingX;
    int barHeight = 3;
    pg.noFill();
    pg.stroke(39, 41, 32);
    pg.rect(screenX + paddingX, screenY + screenHeight - paddingY, barWidth, barHeight);
    
    pg.fill(39, 41, 32);
    
    float timeLeftRatio = 1 - (float)(t - startTime) / maxTime;
    pg.rect(screenX + paddingX + barWidth * (1 - timeLeftRatio), screenY + screenHeight - paddingY, barWidth * timeLeftRatio, barHeight);
  }
  
  private int countLines(String str){
   String[] lines = str.split("\r\n|\r|\n");
   return  lines.length;
  }
  
  public void keyPressed(char k) {
    if (k != 0) {
      progress += step;
    }
  }
  
  public void keyPressed(String s) {
    if (s.length() > 0) {
      progress += step;
    }
  }
  
  public boolean win() {
    return progress >= fullCode.length();
  }
  
  public boolean lose() {
    return millis() - startTime > maxTime;
  }
  
  public boolean shouldShowHeartRate() { return true; }
  public String getDialog() { return "LOOK WHAT YOU JUST DID!"; }
  public int getHeartRateLevel() { return 0; }
}
