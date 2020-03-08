public class PongGame extends State {
  
  int padWidth = 30;
  int padPos = 10;
  int ballX, ballY;
  int vx, vy;
  int pad1x = 0;
  int pad1y = 0;
  int pad2x = 0;
  int pad2y = 0;
  int padPadding = 5;
  int ballSpeed = 1;
  int ballSpeedStep = 1;
  
  int pad1Speed = 8;
  int pad2Speed = 12;
  
  int dx = 1;
  int dy = 1;
  
  
  int score = 0;
  
  PGraphics pg;
  
  public void setup () {
    this.ballX = screenWidth / 2;
    this.ballX = screenHeight / 2;
    this.pad1y = screenHeight / 2;
    this.pad2y = screenHeight / 2;
    this.pad1x = padPadding;
    this.pad2x = screenWidth - padPadding;
    
    this.score = 0;
  }
  
  void start() {
    this.pad1y = screenHeight / 2;
    this.pad2y = screenHeight / 2;
    this.ballX = screenWidth / 2;
    this.ballX = screenHeight / 2;
    this.ballSpeed = 1;
    
    this.score = 0;
  }
  
  public void  draw(PGraphics pg) {
    ballX += dx * ballSpeed;
    ballY += dy * ballSpeed;
    
    if (ballX < 0) {
      ballX = -ballX;
      dx *= -1;
      
      score--;
    }
    
    if (ballX > screenWidth) {
      ballX = screenWidth - (ballX - screenWidth);
      dx *= -1;
      
      score--;
    }
    
    if (ballY < 0) {
      ballY = -ballY;
      dy *= -1;
    }
    
    if (ballY > screenHeight) {
      ballY = screenHeight - (ballY - screenHeight);
      dy *= -1;
    }
    
    if (ballX + dx * ballSpeed <= pad1x && pad1x <= ballX && 
      pad1y - padWidth / 2 <= ballY && ballY <= pad1y + padWidth / 2) 
    {
      // bounce pad
      ballX = pad1x + pad1x - ballX - dx * ballSpeed;
      dx *= -1;
      score++;
    }
    
    if (ballX <= pad2x && pad2x <= ballX + dx * ballSpeed && 
      pad2y - padWidth / 2 <= ballY && ballY <= pad2y + padWidth / 2) 
    {
      // bounce pad
      ballX = pad2x + pad2x - ballX - dx * ballSpeed;
      dx *= -1;
      
      score++;
    }
    
    //println(pg);
    
    pg.fill(0);
    
    pg.ellipse(screenX + ballX - 1, screenY + ballY - 1, 2, 2);
    
    pg.rect(screenX + pad1x, screenY + pad1y - padWidth / 2, 1, padWidth);
    pg.rect(screenX + pad2x, screenY + pad2y - padWidth / 2, 1, padWidth);
    
    pg.fill(93, 98,
     78);
    pg.textSize(9);
    pg.textAlign(CENTER);
    pg.text(score, screenX + screenWidth / 2, 20); 
  }
  
  public void keyPressed(char k) {
    
    if (k == 'q') {
      this.pad1y -= pad1Speed;
    } else if (k == 'a') {
      this.pad1y += pad1Speed;
    } else if (k == 'e') {
      this.pad2y -= pad2Speed;
    } else if (k == 'd') {
      this.pad2y += pad2Speed;
    } else if (k == 'w') {
      this.ballSpeed += ballSpeedStep;
    } else if (k == 's') {
      this.ballSpeed -= ballSpeedStep;
    }
    
    this.pad1y = constrain(this.pad1y, padWidth / 2, this.screenHeight - padWidth / 2);
    this.pad2y = constrain(this.pad2y, padWidth / 2, this.screenHeight - padWidth / 2);
    this.ballSpeed = constrain(this.ballSpeed, 1, 10);
  }
  
  public void keyPressed(String k) {
    
    if ((k.charAt(1) == '0' && k.charAt(2) == 'U') || (k.charAt(1) == '0' && k.charAt(0) == 'D')) {
      this.pad1y -= pad1Speed;
    } else if ((k.charAt(1) == '0' && k.charAt(2) == 'D') || (k.charAt(1) == '1' && k.charAt(0) == 'D')) {
      this.pad1y += pad1Speed;
    } else if ((k.charAt(1) == '1' && k.charAt(2) == 'U') || (k.charAt(1) == '2' && k.charAt(0) == 'D')) {
      this.pad2y -= pad2Speed;
    } else if ((k.charAt(1) == '1' && k.charAt(2) == 'D') || (k.charAt(1) == '3' && k.charAt(0) == 'D')) {
      this.pad2y += pad2Speed;
    } else if (k.charAt(2) == 'L') {
      this.ballSpeed += ballSpeedStep;
    } else if (k.charAt(2) == 'R') {
      this.ballSpeed -= ballSpeedStep;
    }
    
    this.pad1y = constrain(this.pad1y, padWidth / 2, this.screenHeight - padWidth / 2);
    this.pad2y = constrain(this.pad2y, padWidth / 2, this.screenHeight - padWidth / 2);
    this.ballSpeed = constrain(this.ballSpeed, 1, 10);
  }
  
  public boolean win() {
    return score >= 10;
  }
  
  public boolean lose() {
    return score <= -5;
  }
  
  public int getHeartRateLevel() { return 0; }
}
