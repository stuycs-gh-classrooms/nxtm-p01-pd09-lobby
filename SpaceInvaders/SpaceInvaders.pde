boolean gameOver;
int score;
int lives;
int enemyrows;
int enemycols;
int aliens;
Player player;
Enemy[][] enemies;
Projectile[] playerProjectile;
Projectile[] enemyProjectiles;

void setup() {
  background(0, 0, 50);
  size(750, 1000);
  frameRate(60);
  enemyrows = 11;
  enemycols = 9;
  enemies = new Enemy[enemyrows][enemycols];
  playerProjectile = new Projectile[1];
  enemyProjectiles = new Projectile[5];
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
      aliens++;
    }
  }
  player = new Player();
}

void draw() {
  background(0, 0, 50);
  if(player.alive == false){
    if(lives > 0){   
    }
    if(lives == 0){
      gameOver = true;
    }
  }
    if (gameOver == false) {
  if (frameCount % 60 ==0) {
    for (int r = 0; r < enemyrows; r++) {
      for (int c = 0; c < enemycols; c++) {
        enemies[r][c].move();
      }
    }
  }
  if (frameCount % 240 == 0) {
    for (int num = 0; num < 5; num++) {
      int i = int(random(enemyrows));
      int j = int(random(enemycols));
      if (enemies[i][j].alive != false) {
        enemyProjectiles[num] = enemies[i][j].shoot();
      }
    }
  }
  for (int b = 0; b < 5; b++) {
    if (enemyProjectiles[b] != null) {
      enemyProjectiles[b].display();
      enemyProjectiles[b].move();
    }
  }

    textSize(50);
    textAlign(RIGHT);
    text(lives + " lives remaining", width - 20, 50);
    textAlign(LEFT);
    text("SCORE: " + score, 20, 50);
    player.display();
    checkWallCollision();
    checkPlayerProjectileCollision();
    checkEnemyProjectileCollision();
    for (int r = 0; r < enemyrows; r++) {
      for (int c = 0; c < enemycols; c++) {
        enemies[r][c].display();
      }
    }


    for (int i = 0; i < playerProjectile.length; i++) {
      if (playerProjectile[i] != null) {
        playerProjectile[i].display();
        playerProjectile[i].move();
      }
    }
  } else {
    textSize(100);
    textAlign(CENTER);
    text("GAMEOVER", width/2, height/2);
  }
}

void checkWallCollision() {
  for (int row = 0; row < enemyrows; row++) {
    for (int col = 0; col < enemycols; col++) {
      if (enemies[row][col].x + 31 > width || enemies[row][col].x - 1 < 0 ) {
        for (int r = 0; r < enemyrows; r++) {
          for (int c = 0; c < enemycols; c++) {
            enemies[r][c].changeDir();
          }
        }
        return;
      }
    }
  }
}

void checkPlayerProjectileCollision() {
  for (int i = 0; i < playerProjectile.length; i++) {
    if (playerProjectile[i] != null) {
      if (playerProjectile[i].y <= 0) {
        playerProjectile[i] = null;
      } else {
        for (int r = 0; r < enemyrows; r++) {
          for (int c = 0; c < enemycols; c++) {
            if (enemies[r][c].alive == true) {
              if ((enemies[r][c].x - 5 < playerProjectile[i].x && playerProjectile[i].x < enemies[r][c].x + 30)&&(enemies[r][c].y - 1 < playerProjectile[i].y && playerProjectile[i].y < enemies[r][c].y + 20)) {
                enemies[r][c].alive = false;

                playerProjectile[i] = null;
                score += 20;
                return;
              }
            }
          }
        }
      }
    }
  }
}

void checkEnemyProjectileCollision() {
  for (int i = 0; i < enemyProjectiles.length; i++) {
    if (enemyProjectiles[i] != null) {
      if (enemyProjectiles[i].y > height) {
        enemyProjectiles[i] = null;
      } else {
        if ((player.x - 5 < enemyProjectiles[i].x && enemyProjectiles[i].x < player.x + 40)&&(player.y - 1 < enemyProjectiles[i].y && enemyProjectiles[i].y < player.y + 20)) {
          player.alive = false;
          lives --;
          enemyProjectiles[i] = null;
          return;
        }
      }
    }
  }
}

boolean contains(int[] arr, int value) {
  for (int i = 0; i < arr.length; i++) {
    if (arr[i] == value) {
      return true;
    }
  }
  return false;
}

void keyPressed() {
  if (key == 'a') {
    if (player.x - 5 >= 0) {
      player.x -= 5;
    }
  }
  if (key == 'd') {
    if (player.x + 45 <= width) {
      player.x += 5;
    }
  }
}

void mousePressed() {
  for (int i = 0; i < playerProjectile.length; i++) {
    if (playerProjectile[i] == null) {
      playerProjectile[i] = player.shoot();
      return;
    }
  }
}
