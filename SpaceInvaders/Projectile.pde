class Projectile {
  float x, y;
  float speed;

  Projectile(float bx, float by, float s) {
    x = bx;
    y = by;
    speed = s;
  }

  void display() {//draws bullet as point
    stroke(255);
    strokeWeight(5);
    point(x, y);
    strokeWeight(0);
  }

  void move() {
    y += speed;
  }
}
