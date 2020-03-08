public class CarGame extends State {
  
  int winTime = 15000;
  int gameStartTime = 0;
  
  int carSpawnInterval = 1000;
  int lastCarSpawnTime = 0;
  int nLanes = 3;
  
  private int carWidth = 10;
  private int carLength = 20;
  
  public class Car {
    public float y = -carLength;
    public float speed = 1.0 / carSpawnInterval * 800;
    public int lane = 1;
    
    private CarGame game;
    
    public Car (CarGame game) {
      lane = (int)random(0, nLanes);
      this.game = game;
    }
    
    public void draw (PGraphics pg) {
      y += speed;
      
      game.drawCar(pg, lane, (int)y, false);
    }
    
    public boolean isDone() {
      return y > screenHeight;
    }
    
    
  }
  
  ArrayList<Car> cars = new ArrayList<Car>();
  int playerCarLane = 1;
  int playerY = 60;
  
  int dottedLineLength = 5;
  int dottedLineInterval = 15;
  float dottedLineSpeed = 1.5;
  float shift = 0;
  
  PGraphics pg;
  
  public void setup () {
    
  }
  
  public void start() {
    cars.clear();
    lastCarSpawnTime = millis();
    gameStartTime = millis();
  }
  
  public void draw(PGraphics pg) {
    int t = millis();
    
    // lane lines
    
    shift = (shift + dottedLineSpeed) % dottedLineInterval;
    for(int i = 0; i < nLanes - 1; i++){
      for(int j = (int)shift; j < width; j += dottedLineInterval){
        int x = (calculateLaneX(i) + calculateLaneX(i + 1)) / 2;
        pg.stroke(#c8d3a6);
        pg.line (x, screenY + j, x, screenY + j + dottedLineLength);  
      }  
    }
    
    if (t - lastCarSpawnTime > carSpawnInterval) {
      lastCarSpawnTime = t;
      cars.add(new Car(this));
      if (random(0, 1) > 0.3) {
        // extra car
        cars.add(new Car(this));
      }
    }
    for (int i = cars.size() - 1; i >= 0; i--) {
      cars.get(i).draw(pg);
      if (cars.get(i).isDone()) {
        cars.remove(i);
      }
    }
    //rect(0, 0, 20, 20);
       

    drawCar(pg, playerCarLane, playerY, true);
    
    pg.textSize(9);
    pg.textAlign(CENTER);
    
    pg.fill(93, 98, 78);
    pg.text(nf((float)(winTime - (t - gameStartTime)) / 1000, 0, 1), screenX + screenWidth / 2, screenY + 12);
  }
  
  public int calculateLaneX (int lane) {
    int padding = 5;
    int laneWidth = (screenWidth - 2 * padding) / nLanes;
    return screenX + padding + laneWidth * lane + laneWidth / 2;
  }
  
  public void keyPressed(char k) {
    if (k == 'a') {
      playerCarLane = max(playerCarLane - 1, 0);
    } else if (k == 'd') {
      playerCarLane = min(playerCarLane + 1, nLanes - 1);
    }
  }
  
  public void keyPressed(String s) {
    if (s.charAt(2) == 'L') {
      playerCarLane = max(playerCarLane - 1, 0);
    } else if (s.charAt(2) == 'R') {
      playerCarLane = min(playerCarLane + 1, nLanes - 1);
    } else if (s.charAt(1) == '0') {
      playerCarLane = max(playerCarLane - 1, 0);
    } else if (s.charAt(1) == '1') {
      playerCarLane = min(playerCarLane + 1, nLanes - 1);
    }
  }
  
  public void drawCar(PGraphics pg, int lane, int y, boolean isPlayer) {
    int x = calculateLaneX(lane);
    pg.pushMatrix();
    pg.noStroke();
    if (isPlayer)
      pg.fill(#5d624e);
    else
      pg.fill(#272920);
      
    pg.translate(x, screenY + y);
    pg.rect(-carWidth / 2, 0, carWidth, carLength, 4);
    pg.fill(#a3ac88);
    pg.rect(-carWidth / 2 + 1, 6, carWidth - 2, 2, 1);
    pg.rect(-carWidth / 2 + 1, 15, carWidth - 2, 2, 1);
    pg.popMatrix();
  }
  
  public boolean win() {
    return (winTime - (millis() - gameStartTime)) <= 0;
  }
  
  public boolean lose() {
    for (int i = cars.size() - 1; i >= 0; i--) {
      int dy = playerY - (int)cars.get(i).y;
      if (0 < dy && dy < carLength && playerCarLane == cars.get(i).lane) {
        return true;
      }
    }
    return false;
  }
  
  public int getHeartRateLevel() { return 1; }
}
