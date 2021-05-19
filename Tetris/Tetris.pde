/*
Made in: Processing 3.5.3
 Made by: Stijn Holtus
 Made on: 24-2-21
 */
final int[][][] shapes = {  
  {{-1, 0}, {0, 1}, {1, 1}}, //Z_SHAPE
  {{-1, 1}, {0, 1}, {1, 0}}, //S_SHAPE
  {{-1, 1}, {-1, 0}, {1, 0}}, //L_SHAPE
  {{-1, 0}, {1, 0}, {1, 1}}, //J_SHAPE
  {{-1, 0}, {1, 0}, {2, 0}}, //I_SHAPE
  {{0, 1}, {1, 0}, {1, 1}}, //O_SHAPE
  {{-1, 0}, {0, 1}, {1, 0}}    //T_SHAPE
};

final int Z_SHAPE = 0;
final int S_SHAPE = 1;
final int L_SHAPE = 2;
final int J_SHAPE = 3;
final int I_SHAPE = 4;
final int O_SHAPE = 5;
final int T_SHAPE = 6;
final int ACTIVE = 7;
final int NONACTIVE = 8;
final int NOTHING = 9;

final int sizeScreen = 750;
final int margin = sizeScreen/75;
final int textMargin = margin/2;
final int widthBox = sizeScreen/2-margin*20;
final int heightBox = sizeScreen/10;
final int sizeRect = 32;

/*Make field*/
final int heightField = 17; 
final int widthField = 11; 

int[][] field = new int[widthField][heightField];

int rotation = 0;
int nextShape = 0;

int nextLevel = 10;
int level = 1;
int lines = 10;
int score = 0;
int deleteCounter = 0;

long prevMillis;
int waitTime = 1000;

boolean canMove;

boolean lost;

void setup() {
  lost = false;
  size(750, 750);
  for (int i = 0; i < widthField; i++) {
    for (int j = 0; j < heightField; j++) {
      field[i][j] = NOTHING;
    }
  }

  nextShape = floor(random(7));

  spawn();
}

void draw() {
  //nostroke
  strokeWeight(0);

  //set black background
  background(0);

  //set Text align center center
  textAlign(CENTER, CENTER);

  //ScreenRing drawing
  fill(#c4cfa1);
  rect(margin/2, margin/2, sizeScreen-margin, sizeScreen-margin);
  fill(0);
  rect(margin*1.5, margin*1.5, sizeScreen-margin*3, sizeScreen-margin*3);

  //Background drawing
  fill(#414141);
  rect(margin*2, margin*2, sizeScreen-margin*4, sizeScreen-margin*4);
  fill(#c4cfa1);
  rect(sizeScreen/2, sizeScreen/16, sizeScreen/2-margin*2, sizeScreen/4);
  fill(#8b956d);
  rect(sizeScreen/2, sizeScreen/16+margin/2, sizeScreen/2-margin*2, sizeScreen/4-margin);
  fill(#c4cfa1);
  rect(sizeScreen/2, sizeScreen/16+margin*6, sizeScreen/2-margin*2, sizeScreen/4-margin*7);
  fill(#8b956d);
  rect(sizeScreen/2, sizeScreen/16+margin*6.5, sizeScreen/2-margin*2, margin/2);
  fill(#8b956d);
  rect(margin*2, margin*2, 32*11, sizeScreen-margin*4);
  fill(#c4cfa1);
  rect(margin*3.5, margin*9.5, 320, 32*17);

  if (lines <= 0) {
    level = level + 1;
    lines = nextLevel;
    if (nextLevel > 5) {
      nextLevel--;
    }
    waitTime = waitTime - 25;
  }

  //ScoreText
  int xScore = sizeScreen/2+margin*10;
  int yScore = sizeScreen/32;
  int xScoreText = xScore + widthBox / 2;
  int yScoreText = yScore + heightBox / 2;
  //OuterBox
  fill(#c4cfa1);
  rect(xScore, yScore, widthBox, heightBox, 10);
  //InnerBox
  strokeWeight(3);
  rect(xScore+textMargin, yScore+textMargin, widthBox-margin, heightBox-margin, 7);
  strokeWeight(0);
  fill(0);
  textSize(40);
  text("Score", xScoreText, yScoreText);
  fill(20);
  text(""+score, xScoreText, yScoreText*2+heightBox/2+margin);

  //LevelText
  int xLevel = sizeScreen/2+margin*10;
  int yLevel = sizeScreen/32+sizeScreen/10*3-margin*1;
  int xLevelText = xLevel + widthBox / 2;
  int yLevelText = yLevel + heightBox / 2;
  //OuterBox
  fill(#c4cfa1);
  rect(xLevel, yLevel, widthBox, heightBox, 10);
  //InnerBox
  strokeWeight(3);
  rect(xLevel+textMargin, yLevel+textMargin, widthBox-margin, heightBox-margin, 7);
  rect(sizeScreen/2+margin*10.5, sizeScreen/32+sizeScreen/10*3-margin/2, sizeScreen/2-margin*21, sizeScreen/10-margin, 7);
  strokeWeight(0);
  fill(0);
  textSize(30);
  text("Level", xLevelText, yLevelText-margin*2);
  fill(100);
  text(""+level, xLevelText, yLevelText+margin);

  //LinesText
  int xLines = sizeScreen/2+margin*10;
  int yLines = sizeScreen/32+sizeScreen/10*4-margin/2;
  int xLinesText = xLines + widthBox / 2;
  int yLinesText = yLines + heightBox / 2;
  //OuterBox
  fill(#c4cfa1);
  rect(xLines, yLines, widthBox, heightBox, 10);
  //InnerBox
  strokeWeight(3);
  rect(xLines+textMargin, yLines+textMargin, widthBox-margin, heightBox-margin, 7);
  strokeWeight(0);
  fill(0);
  textSize(30);
  text("Lines", xLinesText, yLinesText-margin*2);
  fill(100);
  text(""+lines, xLinesText, yLinesText+margin);

  //NextBlock
  int xBlock = sizeScreen/2+margin*10;
  int yBlock = sizeScreen/32+sizeScreen/10*6;
  int xBlockDraw = xBlock + widthBox / 2;
  int yBlockDraw = yBlock + widthBox / 2;
  int xDelta;
  int yDelta;
  //OuterBox
  fill(#c4cfa1);
  rect(xBlock, yBlock, widthBox, widthBox, 10);
  //Innerbox
  strokeWeight(3);
  rect(xBlock+textMargin, yBlock+textMargin, widthBox-margin, widthBox-margin, 7);
  strokeWeight(0);
  int[][] nextShapeXY = shapes[nextShape];
  xDelta = 0;
  yDelta = 0;
  if (nextShape == I_SHAPE || nextShape == O_SHAPE) {
    xDelta = -sizeRect/2;
  } 
  if (nextShape != I_SHAPE) {
    yDelta = sizeRect/2;
  }
  fill(#8b956d);
  rect(xBlockDraw-sizeRect/2+xDelta, yBlockDraw-sizeRect/2+yDelta, sizeRect, sizeRect);
  fill(#c4cfa1);
  rect(xBlockDraw-sizeRect/2+textMargin+xDelta, yBlockDraw-sizeRect/2+textMargin+yDelta, sizeRect-margin, sizeRect-margin);
  for (int blocks = 0; blocks < 3; blocks++) {
    fill(#8b956d);
    rect(xDelta+(sizeRect*nextShapeXY[blocks][0])+xBlockDraw-sizeRect/2, yDelta+(sizeRect*nextShapeXY[blocks][1]*-1)+yBlockDraw-sizeRect/2, sizeRect, sizeRect);
    fill(#c4cfa1);
    rect(xDelta+(sizeRect*nextShapeXY[blocks][0])+xBlockDraw-sizeRect/2+textMargin, yDelta+(sizeRect*nextShapeXY[blocks][1]*-1)+yBlockDraw-sizeRect/2+textMargin, sizeRect-margin, sizeRect-margin);
  }

  if (lost) {
    textSize(40);
    text("You have lost", sizeScreen/4, sizeScreen/16);
  }


  // alle blokkies op nothing
  for (int i = 0; i < widthField; i++) {
    for (int j = 0; j < heightField; j++) {
      if (field[i][j] == ACTIVE) {
        field[i][j] = NOTHING;
      }
    }
  }

  //--------------------------------------------------choose drawable form-------------------------------------
  for (int x = 0; x < widthField; x++) {
    for (int y = 0; y < heightField; y++) {
      int centerpunchKind = field[x][y];
      if (centerpunchKind < 7) { // is vorm
        int[][] shape = shapes[centerpunchKind];// get a row
        for (int block = 0; block < 3; block++) {
          int xP = 0;
          int yP = 0;
          switch(rotation) {
          case 0:
            xP = shape[block][0];
            yP = shape[block][1];
            break;
          case 1:
            xP = shape[block][1];
            yP = shape[block][0]*-1;
            break;
          case 2:
            xP = shape[block][0]*-1;
            yP = shape[block][1]*-1;
            break;
          case 3:
            xP = shape[block][1]*-1;
            yP = shape[block][0];
            break;
          default:
            break;
          }
          if (field[x+xP][y+yP] != NOTHING) {
            lost = true;
          }
          field[x+xP][y+yP] = ACTIVE;
        }
      }
    }
  }

  float beginX = margin*2;
  float beginY = 32*16+margin*9.5;
  //--------------------------------------------------draw Grid-------------------------------------
  for (int i = 0; i < widthField; i++) {
    for (int j = 0; j < heightField; j++) {
      fill(#c4cfa1);
      rect(beginX+(i*sizeRect), beginY-(j*sizeRect), sizeRect, sizeRect);
      if (field[i][j] == NONACTIVE) {
        fill(#8b956d);
        rect(beginX+(i*sizeRect)+margin/2, beginY-(j*sizeRect)+margin/2, sizeRect-margin, sizeRect-margin);
      }
      if (field[i][j] < 8) {
        fill(#8b956d);
        rect(beginX+(i*sizeRect)+margin/2, beginY-(j*sizeRect)+margin/2, sizeRect-margin, sizeRect-margin);
        fill(#c4cfa1);
        rect(beginX+(i*sizeRect)+margin, beginY-(j*sizeRect)+margin, sizeRect-margin*2, sizeRect-margin*2);
      }
    }
  }
  if (millis() - prevMillis > waitTime) {
    prevMillis = millis();
    canMove = true;
    for (int i = 0; i < widthField; i++) {
      for (int j = 0; j < heightField; j++) {
        if (field[i][j] < 8) {
          if (j <= 0) {
            canMove = false;
          } else if (field[i][j-1] == NONACTIVE) {
            canMove = false;
          }
        }
      }
    }
    for (int i = 0; i < widthField; i++) {
      for (int j = 0; j < heightField; j++) {
        if (field[i][j] < 8) {
          if (canMove == false) {
            field[i][j] = NONACTIVE;
          } else {
            field[i][j-1] = field[i][j];
            field[i][j] = NOTHING;
          }
        }
      }
    }
    if (canMove == false && !lost) {
      checkDelete();
      spawn();
    }
  }
}

void keyReleased() {
  if (key == CODED) {
    switch(keyCode) {
    case UP:
      turn();
      break;

    case DOWN:
      prevMillis = millis() - 1000;
      break;

    case LEFT:
      moveLeft();
      break;

    case RIGHT:
      moveRight();
      break;

    default:
      break;
    }
  }
}



void checkDelete() {

  for (int y=0; y< heightField; y++) {
    int nRow=0;
    for (int x = 0; x < widthField; x++) {
      if (field[x][y] == NONACTIVE) {
        nRow++;
      }
    }
    if (nRow >= widthField) {
      delete(y);
    } else {
      switch(deleteCounter) {
      case 1:
        score = score + 100;
        break;
      case 2:
        score = score + 200;
        break;
      case 3:
        score = score + 500;
        break;
      case 4:
        score = score + 800;
        break;
      default:
        break;
      }
      deleteCounter = 0;
    }
  }
}


void delete(int incomingY) {
  for (int y=incomingY; y< heightField - 1; y++) {
    for (int x = 0; x < widthField; x++) {
      field[x][y] = field[x][y+1];
    }
  }
  deleteCounter++;
  lines = lines - 1;
  checkDelete();
}


void spawn() {
  field [5][14] = nextShape; // spawn old next shape (current shape)
  nextShape = floor(random(7)); // choose next shape (for gui)
  rotation = 0; // reset rotation
}

boolean moveLeft() {
  canMove = true;
  for (int i = 0; i < widthField; i++) {
    for (int j = 0; j < heightField; j++) {
      if (field[i][j] < 8) {
        if (i-1 < 0) {
          canMove = false;
        } else if (field[i-1][j] == NONACTIVE) {
          canMove = false;
        }
      }
    }
  }
  for (int i = 0; i < widthField; i++) {
    for (int j = 0; j < heightField; j++) {
      if (field[i][j] < 8 && canMove) {
        field [i-1][j] = field[i][j];
        field[i][j] = NOTHING;
      }
    }
  }
  return canMove;
}

boolean moveRight() {
  canMove = true;
  for (int i = 0; i < widthField; i++) {
    for (int j = 0; j < heightField; j++) {
      if (field[i][j] < 8) {
        if (i+1 > 10) {
          canMove = false;
        } else if (field[i+1][j] == NONACTIVE) {
          canMove = false;
        }
      }
    }
  }
  for (int i = 9; i >= 0; i--) {
    for (int j = 0; j < heightField; j++) {
      if (field[i][j] < 8 && canMove) {
        field [i+1][j] = field[i][j];
        field[i][j] = NOTHING;
      }
    }
  }
  return canMove;
}

void turn() {
  if (canTurn()) {
    if (rotation >= 3) {
      rotation = 0;
    } else {
      rotation++;
    }
  }
}

boolean canTurn() {
  boolean canTurn = true;
  int possibleRotation = rotation + 1;
  if (possibleRotation == 4) {
    possibleRotation = 0;
  }
  for (int x = 0; x < widthField; x++) {
    for (int y = 0; y < heightField; y++) {
      int centerpunchKind = field[x][y];
      if (centerpunchKind < 7) { // is vorm
        int[][] shape = shapes[centerpunchKind];// get a row
        for (int block = 0; block < 3; block++) {
          int xP = 0;
          int yP = 0;
          switch(possibleRotation) {
          case 0:
            xP = shape[block][0];
            yP = shape[block][1];
            break;
          case 1:
            xP = shape[block][1];
            yP = shape[block][0]*-1;
            break;
          case 2:
            xP = shape[block][0]*-1;
            yP = shape[block][1]*-1;
            break;
          case 3:
            xP = shape[block][1]*-1;
            yP = shape[block][0];
            break;
          default:
            break;
          }
          if (x+xP > widthField-1 || x+xP < 0 || y+yP > heightField-1 || y+yP < 0) {
            canTurn = false;
          } else if (field[x+xP][y+yP] != NOTHING && field[x+xP][y+yP] != ACTIVE) {
            canTurn = false;
          }
        }
      }
    }
  }
  return canTurn;
}
