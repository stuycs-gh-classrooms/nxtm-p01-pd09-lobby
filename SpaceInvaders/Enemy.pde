class Enemy {
  float x, y;
  boolean alive = true;//alive?
  float speed = 1;

  Enemy(float ax, float ay) {//starting position
    x = ax;
    y = ay;
  }

  void display() {
    if (alive) {
      fill(0, 255, 0);
      rect(x, y, 30, 20);
    }
  }

  void move() {
    x += speed;
  }

  void changeDir() {//change direction if hits an edge
    speed *= -1;
    y += 20;
  }
}
