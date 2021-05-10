class Eye {
  
  PVector posEye;
  float radius;
  
  Eye(float xPos, float yPos, float radius) {
    posEye = new PVector(xPos, yPos);
    this.radius = radius;
    
    
  }
  
  void display(float mouseX_, float mouseY_) {
    PVector mouseVector = new PVector(mouseX_, mouseY_);
    PVector posPupil = posEye.copy().add(mouseVector.copy().sub(posEye).setMag(10));
    //noStroke();
    fill(255);
    ellipse(posEye.x, posEye.y, radius, radius);
    fill(0);
    ellipse(posPupil.x, posPupil.y, radius*0.4, radius*0.4);
  }
  
  void update() {
    
    
  }  
}
