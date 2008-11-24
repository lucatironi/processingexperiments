class Disc {
  int x, y;
  float r;
  float angleFromParent;
  Disc[] children;
  boolean isLeaf = false;
  color c = color(0);
  int countDown = (int)random(500);

  void draw() {
    if (tick > countDown) {
      fill(c);
      stroke(c);
      ellipse(x,y,r*2,r*2);
    } else {
      fill(0,0,0, 128);
      stroke(0,0,0,0);
      ellipse(x,y,r*2,r*2);
    }
    drawChildren();
  }

  void drawChildren() {
    if (!isLeaf) {
      recalcFromAngle();
      for (int i=0; i<children.length; i++) {
        children[i].draw();
        if (drawTree) {
          stroke(color(255,255,255,32));
          line(x,y,children[i].x,children[i].y);
        }
      }
    }
  }

  void bend(float amt) {
    angleFromParent += amt;
    if (!isLeaf) {
      for(int i=0; i<children.length; i++) {
        children[i].bend(-amt);
      }
    }
  }

  void recalcFromAngle() {
    for(int i=0; i<children.length; i++) {
      children[i].r = r/scalingFactor;
      children[i].x = (int)(x + cos(children[i].angleFromParent)*(children[i].r + r));
      children[i].y = (int)(y + sin(children[i].angleFromParent)*(children[i].r + r));
    }
  }

  void addChildren(int depth, int count) {
    if (depth == 0) {
      isLeaf = true;
      return;
    }
    children = new Disc[count];
    for (int i=0; i<children.length; i++) {
      children[i]= new Disc();
      //pick a random angle such that this disc doesn't collide with a sibling.
      children[i].angleFromParent = i*TWO_PI/children.length + random(TWO_PI/children.length);
      children[i].c = color(random(255), random(255), random(255), 32*depth);
      children[i].r = r/scalingFactor;
      children[i].x = (int)(x + cos(children[i].angleFromParent)*(children[i].r + r));
      children[i].y = (int)(y + sin(children[i].angleFromParent)*(children[i].r + r));
      children[i].addChildren(depth-1, 2+(int)random(5));
    }
  }
}

