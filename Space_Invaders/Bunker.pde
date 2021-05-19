class Bunker{
  int xpos;
  int ypos;
  
  int hp = 3;
  
  Bunker(int x, int y){
    xpos = x - 24; // - 24
    ypos = y;
  }
  
  void draw(){
    rect(xpos, ypos, 48, 32);
    text(str(hp), xpos, ypos);
  }
  
}
