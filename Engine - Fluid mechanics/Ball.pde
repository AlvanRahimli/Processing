class Ball {
  PVector location;
  PVector velocity;
  PVector acceleration;
  float mass = 1;
  float rad; // radious of ball
  
  Ball() {
    // Initialize variables:
    location = new PVector(random(width), random(height/2));
    velocity = new PVector(15, 0);
    acceleration = new PVector(0, 0.2);
    mass = random(25);
    rad = map(mass, 0, 15, 10, 70);
  }
  
  void update() {
    // Updating velocity and location:
    velocity.add(acceleration);
    location.add(velocity);
    // Deleting acceleration because, 
    // adding acc. will increase it by very huge number!
    // comment out to see difference: :D
    acceleration.mult(0); 
  }
  
  void applyForce(PVector force) {
    // calc.ing force:
    PVector acc = PVector.div(force, mass);
    
    // adding this to acceleration:
    acceleration.add(acc); 
  }
  
  void render() {
    // Just render it:
    stroke(0);
    fill(255, 50);
    ellipse(location.x, location.y, rad, rad);
  }
  
  void checkEdges() {
    // Simple alghoritm to check if it touches to borders:
    if(location.x < 0 || location.x > width) {
      velocity.x *= -1;
    }
    if(location.x > width) {
      location.x = width - 1;
    }
    if(location.y >= height) {
      location.y = height; // this is for making sure;
      velocity.y *= -1;
    }
  }
}
