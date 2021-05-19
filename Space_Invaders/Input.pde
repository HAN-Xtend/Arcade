void keyPressed(){
  if (keyCode == LEFT) {
    player.moveDir = -PLAYER_SPEED;
  }
  
  if (keyCode == RIGHT) {
    player.moveDir = PLAYER_SPEED;
  }
}

void keyReleased(){
  player.moveDir = 0;
}

void keyTyped(){
  if(key == ' ') player.Shoot();
}


boolean rectCollison(int x1, int y1, int w1, int h1, int x2, int y2, int w2, int h2){
  if (x1 + w1 >= x2 &&    // r1 right edge past r2 left
      x1 <= x2 + w2 &&    // r1 left edge past r2 right
      y1 + h1 >= y2 &&    // r1 top edge past r2 bottom
      y1 <= y2 + h2) {    // r1 bottom edge past r2 top
        return true;
  }
  return false;
}
