boolean gameOver;
int score;
int lives;
int enemyrows;
int enemycols;
//Player player;
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
      float x = c * (0.9*width)/enemycols + ((width - ((0.9*width)))+25); //fix
      float y = r * (height/2)/enemyrows + 100;
      enemies[r][c] = new Enemy(x, y);
      enemies[r][c].display();
      // player = new Player();
    }
  }
}
  void draw() {
    if (gameOver == false) {
      textSize(20);
      textAlign(RIGHT);
      text(lives + " lives remaining", width - 20, 50);
//      player.display();
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
      //    player.x - 5;
    }
    if (key == 'd') {
      //    player.x + 5();
    }
  }

  void mousePressed() {
    //  player.shoot();
  }
