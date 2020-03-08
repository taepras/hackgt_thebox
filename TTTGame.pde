public class TTTGame extends State {
  
  
  int[][] board = new int[3][3];
  int cursorX = 1, cursorY = 1;
  
  //int t = millis();
  int lastTurnTime;
  int turnTimeout = 5000;
  
  boolean isPlayerTurn = true;
  
  int turnCount = 0;
  
  public void setup () {
    
  }
  
  public void start () {
    turnCount = 0;
    lastTurnTime = millis();
    isPlayerTurn = true;
    for (int i = 0; i < 3; i++) {
      for (int j = 0; j < 3; j++) {
        board[i][j] = 0;
      }
    }
  }
  
  public void  draw(PGraphics pg) {
    int t = millis();
    if (t - lastTurnTime > turnTimeout) {
      switchTurn();
    }
    
    int cellSize = 15;
    int paddingX = 10;
    int paddingY = 10;
    int highlightPadding = 2;
    int highlightSize = cellSize - 2 * highlightPadding;
    
    pg.noFill();
    pg.stroke(93, 98, 78);
    
    pg.rect(screenX + paddingX + cursorX * cellSize + highlightPadding, screenY + paddingY + cursorY * cellSize + highlightPadding, highlightSize, highlightSize);
    
    pg.noFill();
    pg.stroke(39, 41, 32);
    
    for (int i = 0; i < 3; i++) {
      for (int j = 0; j < 3; j++) {
        pg.rect(screenX + paddingX + i * cellSize , screenY + paddingY + j * cellSize, cellSize, cellSize);
        if (board[i][j] == 1) {
          pg.line(
            screenX + paddingX + i * cellSize + highlightPadding, 
            screenY + paddingY + j * cellSize + highlightPadding, 
            screenX + paddingX + (i + 1) * cellSize - highlightPadding, 
            screenY + paddingY + (j + 1) * cellSize - highlightPadding);
          pg.line(
            screenX + paddingX  + (i + 1) * cellSize - highlightPadding, 
            screenY + paddingY + j * cellSize + highlightPadding, 
            screenX + paddingX + i * cellSize + highlightPadding, 
            screenY + paddingY + (j + 1) * cellSize - highlightPadding);
        } else if (board[i][j] == -1) {
          pg.circle(screenX + paddingX + i * cellSize + cellSize / 2, screenY + paddingY + j * cellSize + cellSize / 2, highlightSize);
        }
      }
    }
  
    pg.textSize(9);
    pg.textAlign(CENTER);
    
    pg.fill(93, 98, 78);
    pg.text(isPlayerTurn ? "your turn" : "comp's turn", screenX + screenWidth / 2, screenY + screenHeight - 15);
    
    
    
    int barWidth = screenWidth - 2 * paddingX;
    int barHeight = 3;
    
    pg.noFill();
    pg.stroke(39, 41, 32);
    pg.rect(screenX + paddingX, screenY + screenHeight - paddingY, barWidth, barHeight);
    
    pg.fill(39, 41, 32);
    
    float timeLeftRatio = 1 - (float)(t - lastTurnTime) / turnTimeout;
    pg.rect(screenX + paddingX + barWidth * (1 - timeLeftRatio), screenY + screenHeight - paddingY, barWidth * timeLeftRatio, barHeight);
    
  
    //if (checkWin(true)) {
      
    //} else if (checkWin(false)) {
      
    //}
  }
  
  private void switchTurn () {
    if (!isPlayerTurn) {
      // coomputer plays
      int x, y;
      do {
        x = (int)random(0, 3);
        y = (int)random(0, 3);
      } while (!placeToken(false, x, y) && turnCount < 9);
    }
    
    int t = millis();
    isPlayerTurn = !isPlayerTurn;
    lastTurnTime = t;
  }
  
  private boolean checkWin (boolean isPlayer) {
    int p = isPlayer ? 1 : -1;
    boolean isWin = (board[0][0] == p && board[0][1] == p && board[0][2] == p) ||
      (board[1][0] == p && board[1][1] == p && board[1][2] == p) ||
      (board[2][0] == p && board[2][1] == p && board[2][2] == p) ||
      (board[0][0] == p && board[1][0] == p && board[2][0] == p) ||
      (board[0][1] == p && board[1][1] == p && board[2][1] == p) ||
      (board[0][2] == p && board[1][2] == p && board[2][2] == p) ||
      (board[0][0] == p && board[1][1] == p && board[2][2] == p) ||
      (board[2][0] == p && board[1][1] == p && board[0][2] == p);
    boolean isTie = turnCount == 9;
    
    return isWin || (isTie && !isPlayer);
  }
  
  private boolean placeToken (boolean isPlayer, int x, int y) {
    if (board[x][y] != 0) {
      return false;
    } else {
      board[x][y] = isPlayer ? 1 : -1;
    }
    
    if(isPlayerTurn)
      switchTurn();
      
    turnCount++;
    
    return true;
  }
  
  
  public void keyPressed(char k) {
    if (k == 'w') {
      cursorY--;
    } else if (k == 'a') {
      cursorX--;
    } else if (k == 's') {
      cursorY++;
    } else if (k == 'd') {
      cursorX++;
    } else if (k == 'e') {
      placeToken(true, cursorX, cursorY);
    }
    
    cursorX = constrain(cursorX, 0, 2);
    cursorY = constrain(cursorY, 0, 2);
  }
  
  public void keyPressed(String s) {
    if (s.equals("E0U")) {
      cursorY--;
    } else if (s.equals("E0L")) {
      cursorX--;
    } else if (s.equals("E0D")) {
      cursorY++;
    } else if (s.equals("E0R")) {
      cursorX++;
    } 
    
    else if (s.charAt(1) == '0' && s.charAt(2) == 'U') {
      cursorY--;
    } else if (s.charAt(2) == 'L' || (s.charAt(1) == '1' && s.charAt(2) == 'U')) {
      cursorX--;
    } else if (s.charAt(1) == '0' && s.charAt(2) == 'D') {
      cursorY++;
    } else if (s.charAt(2) == 'R' || (s.charAt(1) == '1' && s.charAt(2) == 'D')) {
      cursorX++;
    } else if (s.charAt(2) == 'H') {
      placeToken(true, cursorX, cursorY);
    }
    
    cursorX = constrain(cursorX, 0, 2);
    cursorY = constrain(cursorY, 0, 2);
  }
  
  public boolean win() {
    return checkWin(true);
  }
  
  public boolean lose() {
    return checkWin(false);
  }  
  
  public String getDialog() { return "Seems like the stakes are a little low, let's add more things"; }
  public boolean shouldShowHeartRate() { return true; }
  public int getHeartRateLevel() { return 1; }
}
