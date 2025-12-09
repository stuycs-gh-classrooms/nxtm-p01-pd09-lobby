boolean gameOver;
int score;
int lives;
int enemyrows;
int enemycols;
//Player player;
//Enemy[] enemies;

void setup() {
  background(0, 0, 50);
  size(750, 1000);
  
  score = 0;
  lives = 3;
  gameOver = false;
// enemies = new Enemy[enemyrows][enemycols];
// player = new Player();
}

void draw() {
  if (gameOver == false) {
    textSize(20);
    textAlign(RIGHT);
    text(lives + " lives remaining", width - 20, 50);

  } else {
    textSize(100);
    textAlign(CENTER);
    text("GAMEOVER", width/2, height/2);
  }
}

void checkCollision() {
}

void keyPressed() {
  if (key == 'a') {
//    player.left();
  }
  if (key == 'd') {
//    player.right();
  }
}

void mousePressed() {
//  player.shoot();
}
