int block = 100; // resolution of grid
boolean[] invader = new boolean[15];

void setup()
{
  size(block * 7, block * 7);
  frameRate(2);
  background(255);
  noStroke();
}

void draw()
{
  for(int k=0; k<15; k++) {
    invader[k] = boolean(int(random(2)));
  }

  for(int i=0, counter=0; i<5; i++) {
    for(int j=0; j<5; j++) {
      if(counter>19) {
        fill(255 * int(invader[counter-20]));
      } else if(counter>14) {
        fill(255 * int(invader[counter-10]));
      } else {
        fill(255 * int(invader[counter]));
      }
      rect(block + (block * i), block + (block * j), block, block);
      counter++;
    }
  }
}
