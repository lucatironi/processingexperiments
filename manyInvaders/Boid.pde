class Boid {

  PVector loc;
  PVector vel;
  PVector acc;
  float[] tailX;
  float[] tailY;
  float r;
  float maxforce;    // Maximum steering force
  float maxspeed;    // Maximum speed
  int maxTailSegLength;
  int tailSegs;
  PImage face;

  Boid(PVector l, float ms, float mf) {
    acc = new PVector(0,0);
    vel = new PVector(random(-1,1),random(-1,1));
    loc = l.get();
    r = random(1, 5);
    maxspeed = ms;
    maxforce = mf;
    maxTailSegLength = int(random(5, 15));
    tailSegs = int(random(5, 10));

    tailX = new float[tailSegs];
    tailY = new float[tailSegs];

//    face = createImage(5, 5, ARGB);

//    int[] generator = new int[15];
//    int pixel = 0;
//    for(int k=0; k<15; k++) {
//      generator[k] = int(random(2));
//    }

//    for(int i=0, counter=0; i<5; i++) {
//      for(int j=0; j<5; j++) {
//        if(counter>19) {
//          pixel = color(255, 255, 255, 255 * generator[counter-20]);
//        } else if(counter>14) {
//          pixel = color(255, 255, 255, 255 * generator[counter-10]);
//        } else {
//          pixel = color(255, 255, 255, 255 * generator[counter]);
//        }
//        face.pixels[i+j*face.width] = pixel;
//        counter++;
//      }
//    }
//    face.resize(25, 25);
  }

  void run(ArrayList boids) {
    flock(boids);
    update();
    borders();
    render();
  }

  // We accumulate a new acceleration each time based on three rules
  void flock(ArrayList boids) {
    PVector sep = separate(boids);   // Separation
    PVector ali = align(boids);      // Alignment
    PVector coh = cohesion(boids);   // Cohesion
    // Arbitrarily weight these forces
    sep.mult(5.0);
    ali.mult(1.0);
    coh.mult(1.0);
    // Add the force vectors to acceleration
    acc.add(sep);
    acc.add(ali);
    acc.add(coh);
  }
  
  // Method to update location
  void update() {
    // Update velocity
    vel.add(acc);
    // Limit speed
    vel.limit(maxspeed);
    loc.add(vel);
    // Reset accelertion to 0 each cycle
    acc.mult(0);
  }

  void seek(PVector target) {
    acc.add(steer(target,false));
  }
 
  void arrive(PVector target) {
    acc.add(steer(target,true));
  }

  // A method that calculates a steering vector towards a target
  // Takes a second argument, if true, it slows down as it approaches the target
  PVector steer(PVector target, boolean slowdown) {
    PVector steer;  // The steering vector
    PVector desired = target.sub(target,loc);  // A vector pointing from the location to the target
    float d = desired.mag(); // Distance from the target is the magnitude of the vector
    // If the distance is greater than 0, calc steering (otherwise return zero vector)
    if (d > 0) {
      // Normalize desired
      desired.normalize();
      // Two options for desired vector magnitude (1 -- based on distance, 2 -- maxspeed)
      if ((slowdown) && (d < 100.0)) desired.mult(maxspeed*(d/100.0)); // This damping is somewhat arbitrary
      else desired.mult(maxspeed);
      // Steering = Desired minus Velocity
      steer = target.sub(desired,vel);
      steer.limit(maxforce);  // Limit to maximum steering force
    } else {
      steer = new PVector(0,0);
    }
    return steer;
  }
  
  void render() {
    // Draw a quad rotated in the direction of velocity
    float theta = vel.heading2D() + PI/2;
    pushMatrix();
    translate(loc.x,loc.y);
    rotate(theta);
    beginShape(TRIANGLES);
    //texture(face);
    vertex(0, -r*2);
    vertex(r, r*2);
    vertex(-r, r*2);
    endShape();
    popMatrix();
    dragTail(0, loc.x, loc.y);
    for(int i=0; i<tailX.length-1; i++) {
      dragTail(i+1, tailX[i], tailY[i]);
    }
  }
  
  // Wraparound
  void borders() {
    if (loc.x < -r || loc.x > width+r) vel.x *= -1;
    if (loc.y < -r || loc.y > height+r) vel.y *= -1;
  }

  // Separation
  // Method checks for nearby boids and steers away
  PVector separate (ArrayList boids) {
    float desiredseparation = 25.0;
    PVector sum = new PVector(0,0,0);
    int count = 0;
    // For every boid in the system, check if it's too close
    for (int i = 0 ; i < boids.size(); i++) {
      Boid other = (Boid) boids.get(i);
      float d = loc.dist(other.loc);
      // If the distance is greater than 0 and less than an arbitrary amount (0 when you are yourself)
      if ((d > 0) && (d < desiredseparation)) {
        // Calculate vector pointing away from neighbor
        PVector diff = loc.sub(loc,other.loc);
        diff.normalize();
        diff.div(d);        // Weight by distance
        sum.add(diff);
        count++;            // Keep track of how many
      }
    }
    // Average -- divide by how many
    if (count > 0) {
      sum.div((float)count);
    }
    return sum;
  }
  
  // Alignment
  // For every nearby boid in the system, calculate the average velocity
  PVector align (ArrayList boids) {
    float neighbordist = 50.0;
    PVector sum = new PVector(0,0,0);
    int count = 0;
    for (int i = 0 ; i < boids.size(); i++) {
      Boid other = (Boid) boids.get(i);
      float d = loc.dist(other.loc);
      if ((d > 0) && (d < neighbordist)) {
        sum.add(other.vel);
        count++;
      }
    }
    if (count > 0) {
      sum.div((float)count);
      sum.limit(maxforce);
    }
    return sum;
  }

  // Cohesion
  // For the average location (i.e. center) of all nearby boids, calculate steering vector towards that location
  PVector cohesion (ArrayList boids) {
    float neighbordist = 50.0;
    PVector sum = new PVector(0,0);   // Start with empty vector to accumulate all locations
    int count = 0;
    for (int i = 0 ; i < boids.size(); i++) {
      Boid other = (Boid) boids.get(i);
      float d = loc.dist(other.loc);
      if ((d > 0) && (d < neighbordist)) {
        sum.add(other.loc); // Add location
        count++;
      }
    }
    if (count > 0) {
      sum.div((float)count);
      return steer(sum,false);  // Steer towards the location
    }
    return sum;
  }

  // DragTail
  void dragTail(int i, float xin, float yin) {
    float dx = xin - tailX[i];
    float dy = yin - tailY[i];
    float angle = atan2(dy, dx);
    tailX[i] = xin - cos(angle) * maxTailSegLength;
    tailY[i] = yin - sin(angle) * maxTailSegLength;
    segment(tailX[i], tailY[i], angle, 1 / (i+1));
  }

  void segment(float x, float y, float a, float i) {
    pushMatrix();
    translate(x, y);
    rotate(a);
    line(0, 0, maxTailSegLength, 0);
    popMatrix();
  }
}
