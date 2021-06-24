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
  float noiseFactor = 0.01;
  CommunicationHandler com;

  //constructor for center eye
  Eye(float xPos, float yPos, float radius) {
    posEye = new PVector(xPos, yPos);
    posPupil=posEye.copy();
    this.radius = radius;
    eyeColor = color(255, 0, 0);
    isCenterEye= true;
    offsetY = radius*1.4;
    isBlinking = false;
  }

  //constructor for smaller eyes
  Eye(ArrayList <Eye> eyes) {
    while (!canPlaceEye(eyes)); 
    areaEyes += PI * radius * radius;
    isCenterEye = false;
    offsetY = radius*1.4;
    isBlinking = false;
  }

  boolean canPlaceEye(ArrayList <Eye> eyes) {
    radius = random(10, 70);
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

  void checkToGoBlink() {
    n = noise(posEye.x * noiseFactor, posEye.y * noiseFactor, pZero.time);
    if (n > 0.7) {
      isBlinking = true;
    }
  }

  void update(ArrayList <PVector> lookingPositions) {
    if (isBlinking) {
      offsetY -= radius*0.4;
      if (offsetY < 0) isBlinking = false;
    } else if (offsetY < radius * 1.4) {
      offsetY += radius*0.4;
      if (offsetY > radius * 1.4) offsetY = radius*1.4;
    }
    //find the closest person for every individual eye and considering all the people
    float closestDist=999999999;
    for (PVector vector : lookingPositions) {
      if (PVector.dist(posEye, vector)<closestDist) {
        EyeToPerson = PVector.sub(vector, posEye);
        EyeToPerson.setMag(radius*0.8);
        posPupil = new PVector(EyeToPerson.x, EyeToPerson.y).add(posEye);
        println("Vector is closer"+ vector.x+"");
        closestDist=PVector.dist(posEye, vector);
      }
    }

    if (lookingPositions.get(0).z == 0) posPupil = PVector.add(posEye, PVector.sub(new PVector(lookingPositions.get(0).x, lookingPositions.get(0).y), posEye).limit(radius*0.8));
  }
}
