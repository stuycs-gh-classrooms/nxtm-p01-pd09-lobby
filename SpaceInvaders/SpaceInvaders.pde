//SpaceInvaders

//vars
int score;
int lives;
int enemyRows;
int enemyCols;
int timer;
int stage;
int alienTick;
boolean paused;
boolean gameOver;
boolean easyMode;

Player player; //player
Enemy[][] enemies; //2d array of enemies
Projectile[] playerProjectile; //1d array of player projectiles
Projectile[] enemyProjectiles; //1d array of enemy projectiles
Barrier[] barriers; //1d array of barriers

//initialize vars and fill arrays
void setup() {
  background(0, 0, 50);
  size(750, 1000);
  frameRate(60);

  // enemy grid size(9x11)
  enemyRows = 9;
  enemyCols = 11;
  enemies = new Enemy[enemyRows][enemyCols];

  // projectile capacity depends on easyMode toggle
  if (easyMode == true) {
    playerProjectile = new Projectile[100];   // rapid fire
  } else {
    playerProjectile = new Projectile[1];     // normal mode
  }

  enemyProjectiles = new Projectile[5];

  // starting game values
  score = 0;
  lives = 3;
  timer = 0;
  stage = 1;
  alienTick = 60; //aliens start moving once every second
  gameOver = false;

  textSize(100);
  textAlign(CENTER);

  // create barriers
  barriers = new Barrier[4];
  float barrierSpacing = width / 5.0;

  for (int i = 0; i < barriers.length; i++) {
    float barrierX = barrierSpacing * (i + 1) - 20; // space across screen
    float barrierY = height - 150;                  // above player
    barriers[i] = new Barrier(barrierX, barrierY);
  }

  // create enemies in a centered formation
  for (int r = 0; r < enemyRows; r++) {
    for (int c = 0; c < enemyCols; c++) {
      int gap = 20;

      // center the enemy block horizontally
      float x = (width -
        (enemyCols * 30 + (enemyCols - 1) * gap)) / 2 +
        c * (30 + gap);

      // spread rows vertically
      float y = r * (height / 2) / enemyRows + 0.2 * height;

      enemies[r][c] = new Enemy(x, y);
    }
  }

  // create player at default bottom-center
  player = new Player();
}

//game loop, timer screens, movement
void draw() {

  // intro "Get Ready" / "Stage X" countdown
  if (timer < 4) {
    if (frameCount % 60 == 0) {
      timer++;
    }
    background(0);
    textAlign(CENTER);

    if (stage > 1) {
      text("Stage " + stage, width/2, height/2);
    } else {
      fill(255);
      text("Get Ready", width/2, height/2);
    }
  } else {

    background(0, 0, 50);

    // paused overlay
    if (paused == true) {
      textAlign(CENTER);
      fill(255);
      text("PAUSED", width/2, height/2);
    } else {

      // stage clear → reset board, increase difficulty
      if (stageClear() == true) {
        int savescore = score;
        int savestage = stage;
        int savelives = lives;
        int savealientick = alienTick;

        setup();                 // rebuild board

        score = savescore;
        stage = savestage += 1;  // next stage
        lives = savelives;
        alienTick = savealientick / 2; // faster enemies

        //        println(stage);
      }

      // check player death
      if (player.alive == false) {
        if (lives == 0) {
          gameOver = true;
        }
      }

      if (gameOver == false) {

        // draw barriers
        for (int i = 0; i < barriers.length; i++) {
          if (barriers[i] != null && barriers[i].alive) {
            barriers[i].display();
          }
        }

        // enemy movement tick
        if (frameCount % alienTick == 0) {
          for (int r = 0; r < enemyRows; r++) {
            for (int c = 0; c < enemyCols; c++) {
              enemies[r][c].move();
              //              println(enemies[r][c].y);
            }
          }
          checkWallCollision(); // reverse direction if needed
        }

        // enemy firing pattern
        if (frameCount % 240 == 0) {
          for (int num = 0; num < 5; num++) {
            int i = int(random(enemyRows));
            int j = int(random(enemyCols));

            if (enemies[i][j].alive != false) {
              enemyProjectiles[num] = enemies[i][j].shoot();
            }
          }
        }

        // update enemy bullets
        for (int b = 0; b < 5; b++) {
          if (enemyProjectiles[b] != null) {
            enemyProjectiles[b].display();
            enemyProjectiles[b].move();
          }
        }

        //lives counter display
        textSize(50);
        textAlign(RIGHT);
        if (lives == 3) fill(0, 255, 0);
        else if (lives == 2) fill(255, 255, 0);
        else fill(255, 0, 0);
        text(lives + " lives remaining", width - 20, 50);

        //score display
        textAlign(LEFT);
        fill(255);
        text("SCORE: " + score, 20, 50);

        // draw player
        player.display();

        // collision checks
        checkPlayerProjectileCollision();
        checkEnemyProjectileCollision();
        checkEnemyPlayerCollision();

        // draw enemies
        for (int r = 0; r < enemyRows; r++) {
          for (int c = 0; c < enemyCols; c++) {
            enemies[r][c].display();
          }
        }

        // update player bullets
        for (int i = 0; i < playerProjectile.length; i++) {
          if (playerProjectile[i] != null) {
            playerProjectile[i].display();
            playerProjectile[i].move();
          }
        }
      } else {
        // GAME OVER screen
        textSize(100);
        textAlign(CENTER);
        fill(255);
        text("GAMEOVER", width/2, height/2);
        text("Final Score: " + score, width/2, height/2 + 120);
      }
    }
  }
}

//detects alien grid hitting wall
void checkWallCollision() {
  for (int row = 0; row < enemyRows; row++) {
    for (int col = 0; col < enemyCols; col++) {

      // if any enemy hits a wall
      if (enemies[row][col].x + 31 > width || enemies[row][col].x - 1 < 0) {

        // reverse direction of entire formation
        for (int r = 0; r < enemyRows; r++) {
          for (int c = 0; c < enemyCols; c++) {
            enemies[r][c].changeDir();
          }
        }
        return;
      }
    }
  }
}

//returns true only if all enemies are dead
boolean stageClear() {
  for (int r = 0; r < enemyRows; r++) {
    for (int c = 0; c < enemyCols; c++) {
      if (enemies[r][c].alive == true) {
        return false;
      }
    }
  }
  return true;
}

//player's bullets' collisions
void checkPlayerProjectileCollision() {
  for (int i = 0; i < playerProjectile.length; i++) {
    if (playerProjectile[i] != null) {

      // check collision with barriers
      for (int b = 0; b < barriers.length; b++) {
        if (barriers[b] != null && barriers[b].alive) {

          //barrier hitbox
          if ((barriers[b].x - 5 < playerProjectile[i].x && playerProjectile[i].x < barriers[b].x + 40) &&
            (barriers[b].y - 1 < playerProjectile[i].y && playerProjectile[i].y < barriers[b].y + 30)) {

            barriers[b].hit();
            playerProjectile[i] = null;
            return;
          }
        }
      }

      // remove bullet if off-screen
      if (playerProjectile[i].y <= 0) {
        playerProjectile[i] = null;
      } else {

        // check collision with enemies
        for (int r = 0; r < enemyRows; r++) {
          for (int c = 0; c < enemyCols; c++) {

            if (enemies[r][c].alive == true) {

              //hitbox check
              if ((enemies[r][c].x - 2.5 < playerProjectile[i].x && playerProjectile[i].x < enemies[r][c].x + 32.5) &&
                (enemies[r][c].y - 1 < playerProjectile[i].y && playerProjectile[i].y < enemies[r][c].y + 20)) {

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

//check if enemy projectiles hit player
void checkEnemyProjectileCollision() {
  for (int i = 0; i < enemyProjectiles.length; i++) {
    if (enemyProjectiles[i] != null) {

      // check collision with barriers
      for (int b = 0; b < barriers.length; b++) {
        if (barriers[b] != null && barriers[b].alive) {

          if ((barriers[b].x - 5 < enemyProjectiles[i].x && enemyProjectiles[i].x < barriers[b].x + 40) &&
            (barriers[b].y - 1 < enemyProjectiles[i].y && enemyProjectiles[i].y < barriers[b].y + 30)) {

            barriers[b].hit();
            enemyProjectiles[i] = null;
            return;
          }
        }
      }

      // remove off-screen bullet
      if (enemyProjectiles[i].y > height) {
        enemyProjectiles[i] = null;
      } else {

        // hit player
        if ((player.x - 5 < enemyProjectiles[i].x && enemyProjectiles[i].x < player.x + 40) &&
          (player.y - 1 < enemyProjectiles[i].y && enemyProjectiles[i].y < player.y + 20)) {

          player.alive = false;
          lives--;
          enemyProjectiles[i] = null; //remove projectile
          return;
        }
      }
    }
  }
}

//enemy touching player causes a death
void checkEnemyPlayerCollision() {
  for (int r = 0; r < enemyRows; r++) {
    for (int c = 0; c < enemyCols; c++) {

      //hitbox check
      if ((player.x <= enemies[r][c].x && enemies[r][c].y <= player.x + 40) &&
        (player.y <= enemies[r][c].y && enemies[r][c].y <= player.y + 20)) {

        player.alive = false; //player loses a life
        lives--;
        return;
      }
    }
  }
}

//listener for player movement, resets, pause, easy mode
void keyPressed() {

  //move left
  if (key == 'a') {
    if (player.x - 5 >= 0) { //check ahead to make sure doesnt go through left wall
      player.x -= 5;
    }
  }

  //move right
  if (key == 'd') {
    if (player.x + 45 <= width) { //check ahead to make sure doesnt go through right wall
      player.x += 5;
    }
  }

  //reset game
  if (key == 'r') {
    setup();
  }

  //toggle pause
  if (key == ' ') {
    paused = !paused;
  }

  // toggle easy mode and restart game
  if (key == 'm') {
    easyMode = !easyMode;
    setup();
  }
}

//attempts to fire a player bullet
void mousePressed() {
  for (int i = 0; i < playerProjectile.length; i++) {

    // find first empty slot to create a new bullet
    if (playerProjectile[i] == null) {
      playerProjectile[i] = player.shoot();
      return;
    }
  }
}
