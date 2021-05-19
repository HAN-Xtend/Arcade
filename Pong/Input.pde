void keyPressed(){
  if(key == 'w')paddleSpeedLeft = -8;
  else if(key == 's')paddleSpeedLeft = 8;
  
  if(keyCode == UP)paddleSpeedRight = -8;
  else if(keyCode == DOWN)paddleSpeedRight = 8;
}

void keyReleased(){
  if(key == 'w' || key == 's') paddleSpeedLeft = 0;
  if(keyCode == UP || keyCode == DOWN) paddleSpeedRight = 0;
}
