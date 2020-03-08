public class Gary{
  int screenWidth, screenHeight, screenX, screenY;
  PImage garyGary;
  PImage garyOh;
  PImage garyDead;
  public void setup (int screenX, int screenY, int screenWidth, int screenHeight) {
    this.screenX = screenX;
    this.screenY = screenY;
    this.screenWidth = screenWidth;
    this.screenHeight = screenHeight;
    
    garyGary = loadImage("GaryGary.png");
    garyOh = loadImage("GaryOh.png");
    garyDead = loadImage("GaryDead.png");
    
  }
  
  public void draw(PGraphics pg) {
    pg.image(garyGary, screenX, screenY, screenWidth, screenHeight);
  }
}
