Ball[] balls;
Liquid liquid;
Liquid air;
float c = -0.1;

void setup() {
  size(600, 400);
  // Initialize balls, liquid, and air. (liquid and air are same classes):
  balls = new Ball[1];
  liquid = new Liquid(0, 250, width, 150, 0.7, 0.1);
  air = new Liquid(0, 0, width, height - 150, 0.1, 0.1, 100);
  for(int i = 0; i < balls.length; i++) {
    balls[i] = new Ball();
  }
}

void draw() {
  background(50, 120, 240);
  // Render liquid and air:
  liquid.render();
  air.render();
  
  // Iterate throw every ball in array:
  for(Ball b : balls) {
    // Apply gravity;
    PVector gravity = new PVector(0, 1);
    gravity.mult(b.mass);
    b.applyForce(gravity);
    // Apply fluids:
    if(liquid.contains(b)) {
      b.applyForce(liquid.applyDrag(b));
      b.applyForce(liquid.applyArc(b, gravity.y));
    }
    if(air.contains(b)) {
      b.applyForce(air.applyDrag(b));
    }
    
    // You know what these are :D 
    b.update();
    b.checkEdges();
    b.render();
    
    // Visualise velocity of balls:
    PVector endV = new PVector(b.location.x + b.velocity.x * 10, b.location.y + b.velocity.y * 10);
    fill(0);
    line(b.location.x, b.location.y, endV.x, endV.y);
    text(b.mass, b.location.x, b.location.y);
  }
}
