class Enemy {
  color proj;
  float x;
  float y;

  Enemy(float x, float y) {
    this.x = x;
    this.y = y;
  }
  void display() {
    fill(0);
    
    rect(x, y, 25, 5);
  }
}
