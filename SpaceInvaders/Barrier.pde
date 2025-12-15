//Barrier
class Barrier {
  float x, y; //x and y coords of barrier
  int health = 20; //amount of hits barrier can take before being destroyed
  int h; //vertical height of barrier
  boolean alive = true; //tracks if barrier still exists or not


  Barrier(float ax, float ay) { //starting position
    x = ax;
    y = ay;
  } //constructor

  void display() {
    if (alive) {
      fill(0, 200, 255); //blue
      rect(x, y, 40, h + 30);
    }
  } //display

  void hit() {
    health--; //health decreases every time hit by a projectile
    h--; //visually shrink/thin
    if (health <= 0) { //once destroyed
      alive = false; //no longer existing
    }
  } //hit
} //class Barrier
