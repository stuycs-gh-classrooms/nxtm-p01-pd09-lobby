boolean gameOver;
int score;
int lives;
int enemyrows;
int enemycols;
int aliens;
boolean paused;
int timer;
int stage;
Player player;
Enemy[][] enemies;
Projectile[] playerProjectile;
Projectile[] enemyProjectiles;
Barrier[] barriers;

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
  timer = 0;
  stage = 1;
  gameOver = false;
  textSize(100);
  textAlign(CENTER);

  barriers = new Barrier[4];
  float barrierSpacing = width / 5.0;
  for (int i = 0; i < barriers.length; i++) {
    float barrierX = barrierSpacing * (i + 1) - 20; //center each barrier
    float barrierY = height - 150; //position above player
    barriers[i] = new Barrier(barrierX, barrierY);
  }

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
  if (timer < 4) {
    if(frameCount % 60 == 0) {
      timer++;
    }
    background(0);
    if (stage > 1) {
      text("Stage " + stage, width/2, height/2);
    } else {
      text("Get Ready", width/2, height/2);
    }
  }else{

  background(0, 0, 50);
  if (paused == true) {
    textAlign(CENTER);
    fill(255);
    text("PAUSED", width/2, height/2);
  } else {
    if (stageClear() == true) {
      int savescore = score;
      int savestage = stage;
      setup();
      score = savescore;
      stage = savestage++;
    }

    if (player.alive == false) {
      if (lives > 0) {
      }
      if (lives == 0) {
        gameOver = true;
      }
    }
    if (gameOver == false) {

      //display barriers
      for (int i = 0; i < barriers.length; i++) {
        if (barriers[i] != null && barriers[i].alive) {
          barriers[i].display();
        }
      }

      if (frameCount % 60 ==0) {
        for (int r = 0; r < enemyrows; r++) {
          for (int c = 0; c < enemycols; c++) {
            enemies[r][c].move();
            println(enemies[r][c].y);
          }
        }
        checkWallCollision();
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
      if (lives == 3) {
        fill(0, 255, 0);
      } else if (lives == 2) {
        fill(255, 255, 0);
      } else {
        fill(255, 0, 0);
      }
      text(lives + " lives remaining", width - 20, 50);
      textAlign(LEFT);
      fill(255);
      text("SCORE: " + score, 20, 50);
      player.display();
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
      fill(255);
      text("GAMEOVER", width/2, height/2);
      text("Final Score: " + score, width/2, height/2 + 120);
    }
  }
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


boolean stageClear() {
  for (int row = 0; row < enemyrows; row++) {
    for (int col = 0; col < enemycols; col++) {
      if (enemies[row][col].alive == true) {
        return false;
      }
    }
  }
  return true;
}
void checkPlayerProjectileCollision() {
  for (int i = 0; i < playerProjectile.length; i++) {
    if (playerProjectile[i] != null) {

      //check collision with barriers
      for (int b = 0; b < barriers.length; b++) {
        if (barriers[b] != null && barriers[b].alive) {
          if ((barriers[b].x - 5 < playerProjectile[i].x && playerProjectile[i].x < barriers[b].x + 40)&&
            (barriers[b].y - 1 < playerProjectile[i].y && playerProjectile[i].y < barriers[b].y + 30)) {
            barriers[b].hit();
            playerProjectile[i] = null;
            return;
          }
        }
      }

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

      // Check collision with barriers
      for (int b = 0; b < barriers.length; b++) {
        if (barriers[b] != null && barriers[b].alive) {
          if ((barriers[b].x - 5 < enemyProjectiles[i].x && enemyProjectiles[i].x < barriers[b].x + 40)&&
            (barriers[b].y - 1 < enemyProjectiles[i].y && enemyProjectiles[i].y < barriers[b].y + 30)) {
            barriers[b].hit();
            enemyProjectiles[i] = null;
            return;
          }
        }
      }

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
  if (key == 'r') {
    setup();
  }
  if (key == ' ') {
    paused = !paused;
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
