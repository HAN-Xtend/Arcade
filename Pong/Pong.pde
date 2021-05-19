int paddleHeightLeft = 300;
int paddleHeightRight = 300;

int paddleSpeedLeft = 0;
int paddleSpeedRight = 0;

int ballX = 400;
int ballY = 300;

int ballSpeedX = 4;
int ballSpeedY = 4;

int scorePlayerOne = 0;
int scorePlayerTwo = 0;

PFont font;

void setup(){
  size(800, 600);
  noStroke();
  textAlign(CENTER, CENTER);
  font = loadFont("Brandish-50.vlw");
  textFont(font);
}

void draw(){
  update();
  background(0);
  
  //Achtergrond
  fill(200);
  rect(0, 0, width, 20);
  rect(0, height - 20, width, 20);
  for(int i = 0; i < height/20; i++){
    if(i % 2 == 0)rect(width/2 - 10, 20 * i, 20, 20);
  }
  
  
  fill(255);
  
  //paddles
  rect(30, paddleHeightLeft - 50, 20, 100);
  rect(width - 50, paddleHeightRight - 50, 20, 100);
  
  //ball
  rect(ballX, ballY, 15, 15);
  
  text(str(scorePlayerOne), width/2 - 75, 75);
  text(str(scorePlayerTwo), width/2 + 75, 75);
}

void update(){
  paddleHeightLeft += paddleSpeedLeft;
  paddleHeightLeft = constrain(paddleHeightLeft, 70, 530);
  
  paddleHeightRight += paddleSpeedRight;
  paddleHeightRight = constrain(paddleHeightRight, 70, 530);
  
  ballX += ballSpeedX;
  ballY += ballSpeedY;
  
  
  if(ballY < 20 || ballY > height - 35)ballSpeedY = -ballSpeedY;
  
  //Collision paddles
  if(ballX < 50 && ballY > paddleHeightLeft - 50 && ballY < paddleHeightLeft + 50)ballSpeedX = -ballSpeedX;
  if(ballX > 735 && ballY > paddleHeightRight - 50 && ballY < paddleHeightRight + 50)ballSpeedX = -ballSpeedX;
  
  //count points
  if(ballX < 25){
    scorePlayerTwo++;
    ballX = width/2;
    ballY = height/2;
  }
  
  if(ballX > 765){
    scorePlayerOne++;
    ballX = width/2;
    ballY = height/2;
  }
}
