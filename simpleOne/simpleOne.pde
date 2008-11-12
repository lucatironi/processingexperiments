void setup()
{
  size(600, 400);
}

void draw()
{
  background(255);
  line(0, 0, mouseX, mouseY);
  line(width, 0, mouseX, mouseY);
  line(mouseX, mouseY, width, height);
  line(mouseX, mouseY, 0, height);
}
