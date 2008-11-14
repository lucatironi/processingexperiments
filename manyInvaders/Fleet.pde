class Fleet {
  ArrayList invaders; // An arraylist for all the boids

  Fleet() {
    invaders = new ArrayList(); // Initialize the arraylist
  }

  void run() {
    for (int i = 0; i < invaders.size(); i++) {
      Boid b = (Boid) invaders.get(i);  
      b.run(invaders);  // Passing the entire list of boids to each boid individually
    }
  }

  void addInvader(Boid b) {
    invaders.add(b);
  }
}
