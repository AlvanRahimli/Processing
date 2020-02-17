class Liquid {
  float x;
  float y;
  float w;
  float h;
  float p; // dencity;
  float c; // drag constant;
  int opacity;
  
  Liquid(float _x, float _y, float _w, float _h, float _p, float _c) {
    // Initializing variables (w/ default opacity):
    x = _x;
    y = _y;
    w = _w;
    h = _h;
    p = _p;
    c = _c;
    opacity = 220;
  }
  
  Liquid(float _x, float _y, float _w, float _h, float _p, float _c, int op) {
    // Initializing variables
    x = _x;
    y = _y;
    w = _w;
    h = _h;
    p = _p;
    c = _c;
    opacity = op;
  }
  
  void render() {
    // Rendering liquid:
    fill(70, opacity);
    noStroke();
    rect(x, y, w, h);
  }
  
  Boolean contains(Ball ball) {
    // Check if liquid contains given ball
    return ball.location.x >= x && ball.location.y >= y && ball.location.x < x + w && ball.location.y < y + h;
  }
  
  PVector applyDrag(Ball ball) {
    // Calc speed of ball:
    float speed = ball.velocity.mag();
    PVector uV = ball.velocity.copy();
    // Normalize to keep direction only:
    uV.normalize();
    // Calc constant to mult with direction:
    float constant = -p * speed*speed * c;
    PVector force = uV.mult(constant);
    return force;
  }
  
  PVector applyArc(Ball b, float g) {  // g is gravity;
    // Calc archimed force of liquid to ball:
    float arc = this.p * (float)Math.PI * b.rad * b.rad * g;
    float maxArc = this.p * (float)Math.PI * 70 * 70 * g;
    // Mapping archimed force to range(0, 15):
    arc = map(arc, 0, maxArc, 0, 15);
    return new PVector(0, -arc);
  }
}
