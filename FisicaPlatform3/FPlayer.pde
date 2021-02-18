class FPlayer extends FBox {

  //instance variables
  int costumeNum;
  float vx;
  PImage[] currentAction;

  FPlayer() {
    super(gridSize, gridSize);
    this.setPosition(0, 0);
    this.setRotatable(false);
    this.setFillColor(red);
    world.add(this);
    //currentAction = idle;
  }

  void act() {
    vx=0;
    if (leftkey)  vx = -500;
    if (rightkey) vx = 500;
    this.setVelocity(vx, player1.getVelocityY());

    //jumping
    ArrayList<FContact> contacts = this.getContacts();
    if (upkey && contacts.size() > 0) this.setVelocity( this.getVelocityX(), -500);

    //drop bombs
    if (spacekey && bomb == null) {
      bomb = new FBomb();
    }

    if (bomb != null) bomb.act();
  }
}