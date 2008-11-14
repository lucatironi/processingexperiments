Fleet fleet;
Fleet fleet2;

void setup()
{
  size(800, 600, P3D);
  fleet = new Fleet();
  fleet2 = new Fleet();
  // Add an initial set of boids into the system
  for (int i = 0; i < 70; i++) {
    fleet.addInvader(new Boid(new PVector(width / 2, height / 2), 2.0, 0.05));
  }
  for (int i = 0; i < 70; i++) {
    fleet2.addInvader(new Boid(new PVector(width / 2, height / 2), 2.0, 0.05));
  }
  smooth();
  noFill();
  stroke(180, 100);
}

void draw() {
  background(50);
  fleet.run();
  fleet2.run();
}

// Add a new boid into the System
void mousePressed() {
  fleet.addInvader(new Boid(new PVector(mouseX, mouseY), 2.0, 0.05));
}
