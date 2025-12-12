class Barrier {
  float x, y;
  int health = 20;
  boolean alive = true;
  int h;

  Barrier(float ax, float ay) {
    x = ax;
    y = ay;
  }

  void display() {
    if (alive) {
      fill(0, 200, 255);
      rect(x, y, 40, h + 30);
    }
  }

  void hit() {
    health--;
    h--;      // visually erode upward
    if (health <= 0) {
      alive = false;
    }
  }
}
