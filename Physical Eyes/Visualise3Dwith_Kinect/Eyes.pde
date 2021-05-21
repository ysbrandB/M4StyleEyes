class Eye {
  PVector pos;
  PVector closestHead= camPos.copy();
  float angleX, angleY;
  float closestDist;
  Eye(PVector pos) {
    this.pos=pos;
    angleY=0;
    angleX=0;
  }

  void show() {
    closestDist=999999999;
    for (int i=0; i<heads.size(); i++) {
      float distance=PVector.dist(heads.get(i), pos);
      if (distance<closestDist) {
        closestDist=distance;
        closestHead=heads.get(i).copy();
      }
    }
    drawEye(pos, closestHead);
  }

  void drawEye(PVector pos, PVector closestPos) {

    //PVector eyeToHeadY = PVector.sub(new PVector(closestPos.x, closestPos.z), new PVector(pos.x, pos.z));
    //PVector toVectorY = PVector.add(pos, new PVector(eyeToHeadY.x, pos.y, eyeToHeadY.y).normalize().mult(40));
    angleY = PVector.angleBetween(new PVector(pos.x, pos.z), new PVector(closestPos.x, closestPos.z));
    angleX = PVector.angleBetween(new PVector(pos.y, pos.z), new PVector(closestPos.y, closestPos.z));
     
    //PVector eyeToHeadX = PVector.sub(new PVector(closestPos.z, closestPos.y),new PVector(pos.z, pos.y));
    //PVector toVectorX = PVector.add(pos, new PVector(pos.x, eyeToHeadX.y, eyeToHeadX.z));
    ////angleX=-eyeToHeadX.heading();
    
    //PVector fixedFromX = new PVector(pos.y, pos.z);
    //PVector fixedToX = new PVector(toVectorX.y, toVectorX.z);
    //angleX = PVector.angleBetween(fixedFromX, fixedToX);
    stroke(0,0,255);
    pushMatrix();
    
    translate(pos.x, pos.y, pos.z);
    rotateY(angleY);
    //rotateX(angleX);
   
    strokeWeight(3);
    stroke(0, 0, 255);
    
    line(0, 0, 0, 0, 0, 50);
    stroke(0);
    strokeWeight(1);
    popMatrix();
    drawPoint(pos);
  }
}
