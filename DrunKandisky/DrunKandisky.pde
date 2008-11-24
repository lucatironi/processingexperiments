/* 
   DrunKandinsky 
   Copyright 2005
   Sean McCullough
   banksean at yahoo
*/

Disc root = new Disc();
float scalingFactor = 2.0;
int tick = 0;
boolean doDraw = true;
boolean drawTree = false;

void setup() {
  tick=0;
  doDraw=true;

  frameRate(2);
  size(400,400);
  smooth();
  background(0);
  ellipseMode(CENTER);
  root.x = 200;
  root.y = 200;
  root.r = 100;
  root.addChildren(4,7);
}

void keyPressed() {
  if (key == ' ') {
    doDraw = !doDraw;
  } else if (key == 't' || key == 'T') {
    drawTree = !drawTree;
  }
}

void draw() {
  background(0);
  root.draw();

  if (doDraw) {
    float bendAmt = 0.05 * sin(tick * TWO_PI / 500);

    root.bend(bendAmt);
    scalingFactor = 2.5 + 0.25 * sin(tick * TWO_PI / 25);
    tick++;
  }
}

void mousePressed() {
  setup();
}
