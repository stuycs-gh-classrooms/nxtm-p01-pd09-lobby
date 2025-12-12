//Player
class Player {
  float x, y; //x and y coords of player spaceship
  boolean alive = true;//alive?
  
  Player(float px, float py) { //customizable starting coords of spaceship
    x = px;
    y = py;
  } //constructor 

  Player() { //player spaceship default at bottom middle of screen
    this(width/2, height - 40);
  } //overloaded constructor

  void display() {
    fill(0, 200, 255); //blue
    rect(x, y, 40, 20); //display ship as rect
  } //display

  Projectile shoot() {// makes new bullet from player position
    return new Projectile(x + 20, y, -10, 255); //create a white bullet moving upwards from player
  } //shoot
} //class Player
