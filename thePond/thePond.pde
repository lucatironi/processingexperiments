Flock flock;

void setup()
{
  size(800, 600, P3D);
  flock = new Flock();
  // Add an initial set of boids into the system
  for (int i = 0; i < 100; i++) {
    flock.addBoid(new Boid(new PVector(width / 2, height / 2), 2.0, 0.05));
  }
  smooth();
  noFill();
  stroke(180, 100);
}

void draw() {
  background(50);
  flock.run();
}

// Add a new boid into the System
void mousePressed() {
  flock.addBoid(new Boid(new PVector(mouseX, mouseY), 2.0, 0.05));
}
