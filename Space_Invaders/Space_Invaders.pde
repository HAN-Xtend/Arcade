final int MARGIN = 32;
final int PLAYER_SPEED = 4;
final int MAX_BULLETS = 10;

static Player player;
PlayerBullet[] playerBullets = new PlayerBullet[MAX_BULLETS];

Alien[][] alienArray = new Alien[7][4];
EnemyBullet[] enemyBullets = new EnemyBullet[MAX_BULLETS];

Bunker[] bunkers = new Bunker[4];

int alienMoveSpeed = 1;

int globalScore = 0;

boolean gameOver = false;
String gameOverText = "";


void setup(){
  size(800, 600);
  noStroke();
  
  player = new Player();
  
  int alienScore = 4;
  
  for(int x = 0; x < 7; x++){
    for(int y = 0; y < 4;y++){
      if(y == 0) alienScore = 4;
      alienArray[x][y] = new Alien((x * 64) + MARGIN, (y * 64) + MARGIN, 100 * alienScore);
      alienScore--;
    }
  }
  
  for(int j = 0; j < 4; j++){
    int xposition = (width/8) * (j * 2) + width/8;
    bunkers[j] = new Bunker(xposition, height - MARGIN * 4);
  }
}

void draw(){
  background(0);
  
  if(gameOver == false){
    player.draw();
    
    for(int i = 0; i < MAX_BULLETS; i++){
      if(playerBullets[i] != null){
        playerBullets[i].draw();
      }
      
      if(enemyBullets[i] != null){
        enemyBullets[i].draw();
      }
    }
    
    for(int x = 0; x < 7; x++){
      for(int y = 0; y < 4;y++){
        if(alienArray[x][y] != null){
          alienArray[x][y].draw();
        }
      }
    }
    
    for(int j = 0; j < 4; j++){
      if(bunkers[j] != null){
        bunkers[j].draw();
      }
    }
    
    text("Score: " + str(globalScore), 20, 20);
    text("HP: " + str(player.hp), width - 40, 20);
  }else{
    textAlign(CENTER, CENTER);
    text("GAME OVER", width/2, height/2);
    
    text(gameOverText, width/2, height/2 + 20);
  }
}
