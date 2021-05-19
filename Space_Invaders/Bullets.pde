class PlayerBullet{
  int xpos;
  int ypos;
  int arraypos;
  
  PlayerBullet(int x, int y, int arrayPos){
    xpos = x;
    ypos = y;
    arraypos = arrayPos;
  }
  
  void draw(){
    ypos -= 4;
    
    if(ypos < 0) playerBullets[arraypos] = null;
    
    
    for(int j = 0; j < 4; j++){
      if(bunkers[j] != null){
        if(rectCollison(xpos, ypos, 8, 16, bunkers[j].xpos, bunkers[j].ypos, 48, 32)){
          bunkers[j].hp--;
          if(bunkers[j].hp <= 0) bunkers[j] = null;
          
          playerBullets[arraypos] = null;
        }
      }
    }
    
    for(int x = 0; x < 7; x++){
      for(int y = 0; y < 4;y++){
        if(alienArray[x][y] != null){
          if(rectCollison(xpos, ypos, 8, 16, alienArray[x][y].xpos, alienArray[x][y].ypos, 32, 32)){
            globalScore += alienArray[x][y].score;
            
            alienArray[x][y] = null;
            playerBullets[arraypos] = null;
          }
        }
      }
    }
    
    rect(xpos, ypos, 8, 16);
  }
}



class EnemyBullet{
  int xpos;
  int ypos;
  int arraypos;
  
  EnemyBullet(int x, int y, int arrayPos){
    xpos = x;
    ypos = y;
    arraypos = arrayPos;
  }
  
  void draw(){
    ypos += 3;
    
    if(ypos > height) enemyBullets[arraypos] = null;
    
    for(int j = 0; j < 4; j++){
      if(bunkers[j] != null){
        if(rectCollison(xpos, ypos, 8, 16, bunkers[j].xpos, bunkers[j].ypos, 48, 32)){
          bunkers[j].hp--;
          if(bunkers[j].hp <= 0) bunkers[j] = null;
          
          enemyBullets[arraypos] = null;
        }
      }
    }
    

    if(rectCollison(xpos, ypos, 8, 16, player.xpos - 16, player.ypos - MARGIN, 32, 32)){
      player.hp--;
      enemyBullets[arraypos] = null;
    }
    
    rect(xpos, ypos, 8, 16);
  }
}
