class Player {
  int xpos;
  int ypos;
  int moveDir;
  int hp = 3;
  
  
  Player(){
    xpos = width/2;
    ypos = height - MARGIN;
    moveDir = 0;
  }
  
  void draw(){
    if (hp <= 0) {
      gameOver = true;
      gameOverText = "YOU DIED";
    }
    
    xpos += moveDir;
    xpos = constrain(xpos, MARGIN, width - MARGIN);
    rect(xpos - 16, ypos - MARGIN, 32, 32);
  }
  
  void Shoot(){
    for(int i = 0; i < MAX_BULLETS; i++){
      if(playerBullets[i] == null){
        playerBullets[i] = new PlayerBullet(xpos, ypos, i);
        return;
      }
    }
  }
}
