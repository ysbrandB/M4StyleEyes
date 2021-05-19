class DistanceMeter {
  PVector postxt;
  //PVector start;
  PVector end;
  float distance;
  Eye currentEye;
  String dimension;
  PVector txtSize;
  int fontSize;
  float padding;


  DistanceMeter(float dist, Eye currentEye, String dimension) {
    padding = 2;
    //start = screenPos;
    distance = dist;
    this.currentEye = currentEye;
    this.dimension = dimension.toLowerCase();
    fontSize = 25;
    textSize(fontSize);
    txtSize = new PVector(textWidth("" + distance) + padding*2, fontSize + padding*2);

    switch(dimension) {
    case "x": 
      postxt =  new PVector(distance/2, - txtSize.y/2 - padding*2); 
      break;
    case "y": 
      postxt = new PVector(currentEye.getPos().x + 100, currentEye.getPos().z); 
      break;
    case "z": 
      postxt =  new PVector(txtSize.y/2 + currentEye.getPos().x, distance/2); 
      break;
    }
  }

  void display() {
    textAlign(CENTER, CENTER);
    rectMode(CENTER);
    stroke(0);
    strokeWeight(5);
    switch(dimension) {
    case "x": 
      line(0, 0, distance, 0);
      fill(255, 200);
      strokeWeight(1);
      rect(postxt.x, postxt.y, txtSize.x, txtSize.y);
      fill(0);
      text(int(distance), postxt.x, postxt.y);
      break;
    case "y": 
      strokeWeight(1);
      fill(255, 200);
      rect(postxt.x, postxt.y, txtSize.x, txtSize.y);
      fill(0);
      text(int(distance), postxt.x, postxt.y);
      break;
    case "z": 
      line(currentEye.getPos().x, 0, currentEye.getPos().x, distance);
      strokeWeight(1);
      pushMatrix();
      translate(postxt.x, postxt.y);
      rotate(PI/2);
      fill(255, 200);
      rect(0,0, txtSize.x, txtSize.y);
      fill(0);
      text(int(distance), 0, 0);
      popMatrix();
      break;
    }
  }

  //void update(){

  //}

  void updateDist() {
    //switch(dimension) {
    //case "x": 
    //  end = new PVector(start.x + distance, start.y); 
    //  break;
    //case "y": 
    //  postxt = new PVector(currentEye.getPos().x + 20, currentEye.getPos().z); 
    //  break;
    //case "z": 
    //  end = new PVector(start.x, start.y + distance); 
    //  break;
    //}
  }
  
  //float roundN(float num, float n){
  //  return float(round(num * n))/n;
  //}
}
