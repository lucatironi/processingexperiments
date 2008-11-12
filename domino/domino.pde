void setup()
{
  size(600, 400);
  smooth();
  stroke(255);
  frameRate(8);
}

int res = 50; // resolution of grid

void draw()
{
  for(int i=0; i<height; i+=res) {
    for(int j=0; j<width; j+=res) {
      fill(255 * int(random(2)));
      rect(j, i, res, res);
    }
  }
}
