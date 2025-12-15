//Projectile
class Projectile {
  float x, y; //x and y coords of projectile
  float speed; //determines direction and speed of projectile
  color c; //color of projectile

  Projectile(float bx, float by, float s, color cc) { //takes starting position, speed, and color
    x = bx;
    y = by;
    speed = s;
    c = cc;
  } //

  void display() {//draws bullet as point
    stroke(c); //set color of bullet
    strokeWeight(5); //thickness of bullet
    point(x, y); //create bullet
    strokeWeight(0); //reset stroke thickness
  } //display

  void move() { //updates bullet in y direction based on speed
    y += speed;
  } //move
} //class Projectile
