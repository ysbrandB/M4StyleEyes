class Poll {
  PVector position;

  Poll(PVector position) {
    this.position = position;
  }

  void display() {
    pushMatrix();
    translate(position.x, position.y);

    fill(255);
    textSize(26);
    textAlign(LEFT, TOP);
    text("Which color fits better?", 10, 10);
    
    
    
    noStroke();    
    fill(255, 255, 0);
    rect(10, 60, 300*0.8, 40, 8, 0, 0, 8);
    fill(255);
    textSize(18);
    textAlign(RIGHT, CENTER);
    text("80%", 300, 77);
    
    fill(0, 0, 255);
    rect(10, 120, 300*0.2, 40, 8, 0, 0, 8);
    fill(255);
    textSize(18);
    textAlign(RIGHT, CENTER);
    text("20%", 300, 137);
    
    stroke(255);
    noFill();
    rect(10, 60, 300, 40, 8, 8, 8, 8);
    rect(10, 120, 300, 40, 8, 8, 8, 8);
    
    popMatrix();
  }
}
