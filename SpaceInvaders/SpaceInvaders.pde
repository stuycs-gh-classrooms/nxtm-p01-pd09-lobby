boolean gameOver;
int score;
int lives;
color enemy1;
color enemy2;
color playerProj;
color enemyProj;
//Enemy[] enemies;

void setup() {
  background(0, 0, 50);
  size(750, 1000);
  score = 0;
  gameOver = true;
}

void draw() {
  if (gameOver == false) {
    
  } else {
    textSize(100);
    textAlign(CENTER);
    text("GAMEOVER", width/2, height/2);
  }
}

void checkCollision() {
}

void keyPressed() {
}

void mousePressed() {
}
