class LoadEye extends Eye {
  int colorFade;
  int rotation;
  IntList trail = new IntList();
  float timer;
  float timePerStep;
  float radius;

  LoadEye(float xPos, float yPos, float radius) {
    super(xPos, yPos, radius);
    colorFade = 200;
    rotation = 0;
    trail.append(rotation);
    timePerStep = 0.1;
    timer = timePerStep;
    this.radius=radius;
  }

  void display() {
    noStroke();

    //eye white
    fill(255);
    circle(posEye.x, posEye.y, radius*2);

    pushMatrix();
    translate(width/2, height/2);
    for (int i = 0; i<trail.size(); i++) {
      pushMatrix();
      noStroke();
      rotate(radians(trail.get(i)));
      fill(0, 255/trail.size()*float(i + 1));
      rect(0, radius* 0.53, radius/11, radius/3);
      popMatrix();
    }

    if (timer <=0) {
      trail.append(rotation);
      timer = timePerStep;

      if (trail.size() > 5) trail.remove(0);
      rotation+=24;
    }
    popMatrix();
    timer -= 1/frameRate;

    //iris
    fill(eyeColor);
    circle(posPupil.x, posPupil.y, radius*0.8);

    //pupil
    fill(0);
    circle(posPupil.x, posPupil.y, radius*0.5);

    //highlight
    fill(255);
    circle(posPupil.x + radius*0.14, posPupil.y - radius*0.14, radius*0.1);    

    //eyelids
    pushMatrix();
    translate(posEye.x, posEye.y);
    //rotate(posPupil.copy().sub(posEye).heading());
    fill(0);
    strokeWeight(1);
    beginShape();
    vertex(-radius, 0);
    bezierVertex(-radius, -offsetY, radius, -offsetY, radius, 0);
    bezierVertex(radius, -radius*1.4, -radius, -radius*1.4, -radius, 0);
    endShape();
    beginShape();
    vertex(-radius, 0);
    bezierVertex(-radius, offsetY, radius, offsetY, radius, 0);
    bezierVertex(radius, radius*1.4, -radius, radius*1.4, -radius, 0);
    endShape();
    popMatrix();

    //mask eye
    fill(0);
    stroke(0);
    strokeWeight(radius*0.22);
    noFill();
    circle(posEye.x, posEye.y, radius * 2 + radius*0.22);
    strokeWeight(1);
  }
}
