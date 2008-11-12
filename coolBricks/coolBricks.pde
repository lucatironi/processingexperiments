void setup()
{
  size(600, 400);
  smooth();
  stroke(255);
  background(0);
  frameRate(1);
}

int block = 20;
int xRes = block * 3; // resolution of grid
int yRes = block * 2; // resolution of grid

void draw()
{
  for(int i=0; i<height; i+=yRes) {
    for(int j=0; j<width; j+=xRes) {
      int r = int(random(6));
      if(r == 0) {
        brick_0(j,i,block);
      } else if (r == 1) {
        brick_1(j,i,block);
      } else if (r == 2) {
        brick_2(j,i,block);
      } else if (r == 3) {
        brick_3(j,i,block);
      } else if (r == 4) {
        brick_4(j,i,block);
      } else if (r == 5) {
        brick_5(j,i,block);
      }
    }
  }
}

void brick_0(int x, int y, int block)
{
  fill(255);
  rect(x, y, block, block * 2);
  fill(0);
  rect(x + block, y, block * 2, block);
  fill(0);
  rect(x + block, y + block, block * 2, block);
}

void brick_1(int x, int y, int block)
{
  fill(0);
  rect(x, y, block, block * 2);
  fill(255);
  rect(x + block, y, block * 2, block);
  fill(0);
  rect(x + block, y + block, block * 2, block);
}

void brick_2(int x, int y, int block)
{
  fill(0);
  rect(x, y, block, block * 2);
  fill(0);
  rect(x + block, y, block * 2, block);
  fill(255);
  rect(x + block, y + block, block * 2, block);
}

void brick_3(int x, int y, int block)
{
  fill(0);
  rect(x, y, block * 2, block);
  fill(0);
  rect(x, y + block, block * 2, block);
  fill(255);
  rect(x + (block * 2), y, block, block * 2);
}

void brick_4(int x, int y, int block)
{
  fill(255);
  rect(x, y, block * 2, block);
  fill(0);
  rect(x, y + block, block * 2, block);
  fill(0);
  rect(x + (block * 2), y, block, block * 2);
}

void brick_5(int x, int y, int block)
{
  fill(0);
  rect(x, y, block * 2, block);
  fill(255);
  rect(x, y + block, block * 2, block);
  fill(0);
  rect(x + (block * 2), y, block, block * 2);
}
