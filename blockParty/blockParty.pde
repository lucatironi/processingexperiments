void setup()
{
  size(600, 400);
  frameRate(12);
}

int res = 10; // resolution of grid

void draw()
{
  background(0);
  for(int i=0; i<height; i+=res) {
    for(int j=0; j<width; j+=res) {
      fill(color(int(random(255)), int(random(255)), int(random(255))));
      rect(j, i, res, res);
    }
  }
}
