boolean gameOver;
int score;
int lives;
int enemyrows;
int enemycols;
Player player;
Enemy[][] enemies;

void setup() {
  background(0, 0, 50);
  size(750, 1000);
  enemyrows = 11;
  enemycols = 9;
  enemies = new Enemy[enemyrows][enemycols];
  score = 0;
  lives = 3;
  gameOver = false;
  for (int r = 0; r < enemyrows; r++) {
    for (int c = 0; c < enemycols; c++) {
      int gap = 20;
      float x = (width - //(total width - space taken by enemies)/2 gives left margin
      (enemycols * 30 +// space taken up by all enemies +
      (enemycols - 1)* gap)) 
      / 2 + 
      c * (30 + gap); //position based on column #
      float y = r * (height/2)/enemyrows + 0.2*height;
      enemies[r][c] = new Enemy(x, y);
      player = new Player();
    }
  }
}
void draw() {
  background(0, 0, 50);
  if (gameOver == false) {
    textSize(20);
    textAlign(RIGHT);
    text(lives + " lives remaining", width - 20, 50);
    player.display();
    for (int r = 0; r < enemyrows; r++) {
      for (int c = 0; c < enemycols; c++) {
        enemies[r][c].display();
        enemies[r][c].move();
      }
    }
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
    player.x -= 5;
  }
  if (key == 'd') {
    player.x += 5;
  }
}

void mousePressed() {
    player.shoot();
}
