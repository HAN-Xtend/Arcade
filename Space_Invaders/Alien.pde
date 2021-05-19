class Alien{
  int score;
  int xpos;
  int ypos;
  color col;
  
  float shootTimer = random(120);
  
  Alien(int x, int y, int Score){
    score = Score;
    xpos = x;
    ypos = y;
    
    switch(score){
      case 100:
        col = color(255, 0, 0);
        break;
      case 200:
        col = color(0, 255, 0);
        break;
      case 300:
        col = color(0, 0, 255);
        break;
      case 400:
        col = color(255);
        break;
    }
  }
  
  void draw(){
    checkForGround();
    
    xpos += alienMoveSpeed;
    
    fill(col);
    rect(xpos, ypos, 32, 32);
    fill(255);
    
    checkForWall();
    
    shoot();
  }
  
  void checkForWall(){
    if(xpos > width - MARGIN * 2 || xpos < MARGIN){
      alienMoveSpeed = -alienMoveSpeed;
      xpos += alienMoveSpeed * 2;
      
      for(int x = 0; x < 7; x++){
        for(int y = 0; y < 4;y++){
          if(alienArray[x][y] != null){
            alienArray[x][y].ypos += 64;
            alienArray[x][y].xpos += alienMoveSpeed;
          }
        }
      }
    }
  }
  
  void checkForGround(){
    if(ypos >= height - MARGIN * 4){
      gameOver = true;
      gameOverText = "ALIENS INVADED EARTH";
    }
  }
  
  
  void shoot(){
    shootTimer -= 0.05;
    
    if(shootTimer <= 0){
      shootTimer = random(120);
      
      for(int i = 0; i < MAX_BULLETS; i++){
        if(enemyBullets[i] == null){
          enemyBullets[i] = new EnemyBullet(xpos, ypos, i);
          return;
        }
      }
    }
  }
}
