class Player {
  float x, y;
  float speed = 5;
  boolean alive = true;//alive?
  Player(float px, float py) {
    x = px;
    y = py;
  } //main

  Player() {
    this(width/2, height - 40);
  }

  void display() {
    fill(0, 200, 255);
    rect(x, y, 40, 20);
  }

  Projectile shoot() {// makes new bullet from player position
    return new Projectile(x + 20, y, -5, 255);
  }
}
