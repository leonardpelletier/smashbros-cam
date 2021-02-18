import fisica.*;
FWorld world;

//global variables

color black = #000000;
color green = #00FF00;
color red   = #FF0000;
color blue  = #0000FF;
color orange= #F0A000;
color brown = #996633;

PImage map;
int gridSize = 32;
FPlayer player1;
FBox player2;
FBomb bomb = null;

float vy, zoomfactor, angle;

boolean upkey, downkey, leftkey, rightkey, wkey, akey, skey, dkey, qkey, ekey, spacekey;

ArrayList<FBox> boxes = new ArrayList<FBox>();

void setup() {
  size (600, 600);

  Fisica.init(this);
  world = new FWorld(-2000, -2000, 2000, 2000);
  world.setGravity(0, 900);
  map = loadImage("map.png");

  int x = 0;
  int y = 0;
  while (y < map.height) {
    color c = map.get(x, y);
    if (c == black) {
      FBox b = new FBox(gridSize, gridSize);
      b.setName("plain");
      b.setStatic(true);
      b.setFillColor(black);
      b.setPosition(x*gridSize, y*gridSize);
      world.add(b);
      boxes.add(b);
    }
    if (c == brown) {
      new FBridge(x,y);
    }
    if (c == green) {
      FBox b = new FBox(gridSize, gridSize);
      b.setStatic(true);
      b.setFillColor(green);
      b.setStrokeColor(green);
      b.setPosition(x*gridSize, y*gridSize);
      world.add(b);
    }
    x++;
    if (x > map.width) {
      y++;
      x = 0;
    }
  }
  
  //runLeft = new PImage[3];
  //runLeft[0] = loadImage(...);

  player1 = new FPlayer();

  player2 = new FBox(gridSize, gridSize);
  player2.setFillColor(blue);
  player2.setStrokeColor(blue);
  player2.setPosition(100, 0);
  world.add(player2);
}

void draw() {
  zoomfactor = 300/dist(player1.getX(), player1.getY(), player2.getX(), player2.getY());
  background(255);
  
  pushMatrix();
  translate(-avgXPos()*zoomfactor + width/2, -avgYPos()*zoomfactor + height/2);
  //translate(-player1.getX()*zoomfactor + width/2, -player1.getY()*zoomfactor + height/2);
  scale(zoomfactor);
  world.step();
  world.draw();
  popMatrix();
  
  player1.act(); 
  
  for(int i = 0; i < boxes.size(); i++) {
    FBox b = boxes.get(i);
    if (b instanceof FBridge) {
      FBridge bridge = (FBridge) b; //downcasting
      bridge.act();
    }
    //if (b instanceof FLava) {
    //  FLava lava = (FLava) b; //downcasting
    //  lava.act();
    //}
  }
  
  
}

float avgXPos () {
  return (player1.getX() + player2.getX())/2.0;
}

float avgYPos () {
  return (player1.getY() + player2.getY())/2.0;
}

void keyPressed() {
  if (key == 'S' || key == 's') skey = true;
  if (key == 'W' || key == 'w') wkey = true;
  if (key == 'A' || key == 'a') akey = true;
  if (key == 'D' || key == 'd') dkey = true;
  if (key == 'Q' || key == 'q') qkey = true;
  if (key == 'E' || key == 'e') ekey = true;
  if (key == ' ') spacekey = true;
  if (keyCode == DOWN)  downkey  = true;
  if (keyCode == UP)    upkey    = true;
  if (keyCode == LEFT)  leftkey  = true;
  if (keyCode == RIGHT) rightkey = true;
}

void keyReleased() {
  if (key == 'S' || key == 's') skey = false;
  if (key == 'W' || key == 'w') wkey = false;
  if (key == 'A' || key == 'a') akey = false;
  if (key == 'D' || key == 'd') dkey = false;
  if (key == 'Q' || key == 'q') qkey = false;
  if (key == 'E' || key == 'e') ekey = false;
  if (key == ' ') spacekey = false;
  if (keyCode == DOWN)  downkey  = false;
  if (keyCode == UP)    upkey    = false;
  if (keyCode == LEFT)  leftkey  = false;
  if (keyCode == RIGHT) rightkey = false;
}