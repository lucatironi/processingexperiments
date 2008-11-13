int limit = 50;
int block = 25;
Invader[] invaders = new Invader[limit];

void setup()
{
  size(block * 20, block * 15);
  frameRate(2);
  background(255);
  noStroke();

  for (int i=0; i<invaders.length; i++){
    invaders[i] = new Invader(int(random(0, width - block)), int(random(0, height - block)), int(random(pow(2,15))), (block / 25));
  }
}

void draw()
{
  for (int i=0; i<invaders.length; i++){
    invaders[i].draw();
  }
}
