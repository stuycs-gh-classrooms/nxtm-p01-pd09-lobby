class Projectile {
  float x, y;
  float speed;
  color c;

  Projectile(float bx, float by, float s, color cc) {
    x = bx;
    y = by;
    speed = s;
    c = cc;
    
  }

  void display() {//draws bullet as point
    stroke(c);
    strokeWeight(5);
   
    point(x, y);
    strokeWeight(0);
  }

  void move() {
    y += speed;
  }
}
