void setup()
{
  size(600, 400);
  stroke(255);
  frameRate(6);
}

int res = 50; // resolution of grid
int arcres = 48; // resolution of the arc

void draw()
{
  background(0);
  for(int i=0; i<height; i+=res) {
    for(int j=0; j<width; j+=res) {
      int r = int(random(4));
      if(r == 0) {
        arc_0(j,i,res);
      } else if (r == 1) {
        arc_1(j,i,res);
      } else if (r == 2) {
        arc_2(j,i,res);
      } else if (r == 3) {
         arc_3(j,i,res);
      }
    }
  }
}

void arc_0(int xC, int yC, int r)
{
  int x = 0, y = r, u = 1, v = 2 * r - 1, E = 0;
  while (x < y) {
    thin_point(xC + y, yC - x + res); // ESE
    x++; E += u; u += 2;
    if (v < 2 * E){
      y--; E -= v; v -= 2;
    }
    if (x>y) break;
    thin_point(xC + x, yC - y + res); //SSE
  }
}

void arc_1(int xC, int yC, int r)
{
  int x = 0, y = r, u = 1, v = 2 * r - 1, E = 0;
  while (x < y) {
    thin_point(xC + x, yC + y); // NNE
    x++; E += u; u += 2;
    if (v < 2 * E){
      y--; E -= v; v -= 2;
    }
    if (x > y) break;
    thin_point(xC + y, yC + x); // ENE
  }
}

void arc_2(int xC, int yC, int r)
{
  int x = 0, y = r, u = 1, v = 2 * r - 1, E = 0;
  while (x < y) {
    thin_point(xC - y + res, yC + x); // WNW
    x++; E += u; u += 2;
    if (v < 2 * E){
      y--; E -= v; v -= 2;
    }
    if(x > y) break;
    thin_point(xC - x + res, yC +y); //NNW
  }
}

void arc_3(int xC, int yC, int r)
{
  int x = 0, y = r, u = 1, v = 2 * r - 1, E = 0;
  while (x < y) {
    thin_point(xC - x + res, yC - y + res); // SSW
    x++; E += u; u += 2;
    if (v < 2 * E){
      y--; E -= v; v -= 2;
    }
    if (x > y) break;
    thin_point(xC - y + res, yC - x + res); // WSW
  }
}

void thin_point(int x, int y)
{
  point(x, y);
}
