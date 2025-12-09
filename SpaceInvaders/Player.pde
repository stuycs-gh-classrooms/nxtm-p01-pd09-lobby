class Player {
  float x, y;
  float speed = 5;

  Player(float px, float py) {
    x = px;
    y = py;
  } //main
  
  Player(){
    this(width/2, height - 40);
  }
  
  void display() {
    fill(0, 200, 255);
    rect(x, y, 40, 20);
  }

  void moveLeft() { //dont rly need this
    x -= speed;
  }

  void moveRight() { //or this
    x += speed;
  }

  Projectile shoot() {// makes new bullet from player position
    return new Projectile(x + 20, y, -5);
  }
}
