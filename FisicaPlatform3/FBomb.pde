class FBomb extends FBox {

  //instance variables
  int timer;

  //constructor
  FBomb() {
    super(gridSize, gridSize);//calling FBox const.
    //must go first!
    this.setFillColor(orange);
    this.setPosition(player1.getX()+gridSize, player1.getY());
    world.add(this);
    timer = 60;
  }

  //behaviour functions
  void act() {
    timer--;
    if (timer == 0) {
      explode();
      world.remove(this);
      bomb = null;
    }
  }

  void explode() {
    for (int i = 0; i < boxes.size(); i++) {
      FBox b = boxes.get(i);
      if (dist(this.getX(), this.getY(), b.getX(), b.getY()) < 200) {
        //b.setFillColor(orange);
        b.setStatic(false);
        float vx = b.getX() - this.getX();
        float vy = b.getY() - this.getY();
        b.setVelocity(vx*5, vy*5);
      }
    }
  }
}