class Invader {

  int startX, startY;
  int seed;
  int size;
  int[] body;

  Invader(int x, int y, int seed, int size) {
    this.startX = x;
    this.startY = y;
    this.seed = seed;
    this.size = size;

    body = new int[25];
    for(int k=0; k<body.length; k++) {
      body[k] = 255 * int(random(2));
    }
  }

  void draw() {

  beginDraw();
  for (int x = 0; x < pg.width; x++, xc += pixelSize)
  {
    float  yc    = 25;
    float s1 = 128 + 128 * sin(radians(xc) * calculation1 );

    for (int y = 0; y < pg.height; y++, yc += pixelSize)
    {
      float s2 = 128 + 128 * sin(radians(yc) * calculation2 );
      float s3 = 128 + 128 * sin(radians((xc + yc + timeDisplacement * 5) / 2));  
      float s  = (s1+ s2 + s3) / 3;
      pixels[x+y*pg.width] = color(s, 255 - s / 2.0, 255);
    }
  }
  endDraw();

  }
}
