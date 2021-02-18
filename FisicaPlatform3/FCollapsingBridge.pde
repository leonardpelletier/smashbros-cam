class FBridge extends FBox {
  
  FBridge(int x, int y) {
    super(gridSize, gridSize);
    this.setName("bridge");
    this.setStatic(true);
    this.setFillColor(brown);
    this.setPosition(x*gridSize, y*gridSize);
    world.add(this);
    boxes.add(this);
  }
  
  void act() {
    ArrayList<FContact> contacts = this.getContacts();
    for (int i = 0; i < contacts.size(); i++) {
      FContact c = contacts.get(i);
      if (c.contains(player1)) {
        this.setStatic(false);
      }
    }
  }
  
  
  
  
  
}