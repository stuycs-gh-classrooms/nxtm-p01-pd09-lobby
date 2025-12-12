//Enemy
class Enemy {
  float x, y; //x and y coords of enemy 
  boolean alive = true; //alive?
  float speed = 5; //moves 5 pixels at a time

  Enemy(float ax, float ay) {//starting position
    x = ax;
    y = ay;
  } //constructor
  

  void display() {
    if (alive) { //only show alien if they are still alive
      fill(0, 150, 0); //dark green
      rect(x, y, 30, 20); 
    }
  } //display

  void move() { //update enemy x coordinate based on speed
    x += speed;
  } //move

  void changeDir() {//change direction if hits an edge
    speed *= -1; //start moving other direction
    y += 20; //move down closer towards player
  } //changeDir

  Projectile shoot() {// makes new bullet from player position
    return new Projectile(x + 15, y - 20, 5, #FF0000); //red projectile moving downwards from enemy
  } //shoot
} //class Enemy
