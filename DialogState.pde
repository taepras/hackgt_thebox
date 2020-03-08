public class DialogState extends State{
  String message;
  boolean isDone;
  int timeStart;
  int endTime = 3000;
  int minStartTime = 300;
  boolean isAuto;
  
  public DialogState (String message, boolean isAuto) {
    this.message = message;
    this.isAuto = isAuto;
  }
  
  public void setup () {
    
  }
  
  public void start() { 
    timeStart = millis(); 
    isDone = false;
    println("XXX");
  }
  
  //public void next() {
  //  print(dialogs.get(currentDialog));
  //  currentDialog++;
  //}
  public void draw(PGraphics pg) {
    pg.textSize(9);
    pg.textAlign(CENTER, CENTER);
    pg.fill(93, 98, 78);
    
    pg.text(message, screenX + screenWidth / 2, screenY + screenHeight / 2);
  }
  
  public void keyPressed(char k) {
    isDone = true;
  }
  
  public void keyPressed(String s) {
    isDone = true;
  }
  
  public boolean win() {
    return (!isAuto && isDone && millis() - timeStart > minStartTime) || 
      (isAuto && millis() - timeStart > endTime);
  }
  
  public boolean lose() {
    return false;
  }
  
  public boolean needStart() { return false; }
}
