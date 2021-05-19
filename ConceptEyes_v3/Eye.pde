class Eye {

  PVector posEye;
  PVector posPupil;
  PVector EyeToPerson;
  float radius;
  float distance;
  float maxDist;
  color eyeColor;
  boolean isCenterEye;
  float offsetY;
  boolean isBlinking;
  int myEyeImage;
  float n;

  //constructer for center eye
  Eye(float xPos, float yPos, float radius) {
    posEye = new PVector(xPos, yPos);
    this.radius = radius;
    eyeColor = color(255, 0, 0);
    isCenterEye= true;
    offsetY = radius*1.4;
    isBlinking = false;
  }

  //constructor for smaller eyes
  Eye() {
    myEyeImage=int(random(0, 50));
    while (!canPlaceEye());
    areaEyes += PI * radius * radius;
    isCenterEye = false;
    offsetY = radius*1.4;
    isBlinking = false;
  }

  boolean canPlaceEye() {
    radius = random(15, 100);
    posEye = new PVector(random(radius, width-radius), random(radius, height-radius));
    posPupil = new PVector(random(radius, width-radius), random(radius, height-radius));
    colorMode(HSB, 255);
    eyeColor = color(random(75, 175), random(100, 255), random(200, 255));
    colorMode(RGB);

    for (int i = 0; i < eyes.size(); i++) {
      distance = dist(posEye.x, posEye.y, eyes.get(i).posEye.x, eyes.get(i).posEye.y);
      maxDist = radius + eyes.get(i).radius;
      if (distance <= maxDist + radius*0.2) {
        return false;
      }
    }
    return true;
  }


  void display() {
    noStroke();

    //eye white
    fill(255);
    circle(posEye.x, posEye.y, radius*2);

    //iris
    fill(eyeColor);
    circle(posPupil.x, posPupil.y, radius*0.8);
    if (useImages) {
      if (isCenterEye) {
        image(centerEyeIris, posPupil.x, posPupil.y, radius*0.9, radius*0.9);
      } else {
        image(eyeImages[myEyeImage], posPupil.x, posPupil.y, radius*0.9, radius*0.9); //image instead of color
      }
    }

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

  void blinkEye() {
    isBlinking = true;
  }

  void update(PVector lookingPosition) {
    if (frameCount%100 == 0) {
      n = noise(posEye.x * noiseFactor, posEye.y * noiseFactor, time);
      if (n > 0.6) isBlinking = true;
    }
    
    if (isBlinking) {
      offsetY -= radius*0.4;
      if (offsetY < 0) isBlinking = false;
    } else if (offsetY < radius * 1.4) {
      offsetY += radius*0.4;
      if (offsetY > radius * 1.4) offsetY = radius*1.4;
    }

    EyeToPerson = PVector.sub(new PVector(lookingPosition.x, lookingPosition.y, lookingPosition.z), posEye);
    EyeToPerson.setMag(radius*0.8);
    posPupil = new PVector(EyeToPerson.x, EyeToPerson.y).add(posEye);

    if (lookingPosition.z == 0) posPupil = PVector.add(posEye, PVector.sub(new PVector(lookingPosition.x, lookingPosition.y), posEye).limit(radius*0.8));
  }
}
