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
      postxt =  new PVector(distance/2, -txtSize.y/2 - padding*2); 
      break;
    case "y": 
      postxt = new PVector(currentEye.getPos().x + 100, currentEye.getPos().z); 
      break;
    case "z": 
      postxt =  new PVector(currentEye.getPos().x, distance/2); 
      break;
    }
  }

  void display() {
    textAlign(CENTER, CENTER);
    rectMode(CENTER);
    textSize(20);
    stroke(0);
    strokeWeight(5);
    switch(dimension) {
    case "x": 
      line(0, 0, distance*zoom, 0);
      fill(255, 200);
      strokeWeight(1);
      rect(postxt.x*zoom, postxt.y*zoom, txtSize.x, txtSize.y);
      fill(0);
      text(int(distance), postxt.x*zoom, postxt.y*zoom);
      break;
    case "y": 
      strokeWeight(1);
      fill(255, 200);
      rect(postxt.x*zoom, postxt.y*zoom, txtSize.x, txtSize.y);
      fill(0);
      text(int(distance), postxt.x*zoom, postxt.y*zoom);
      break;
    case "z": 
      line(currentEye.getPos().x*zoom, 0, currentEye.getPos().x*zoom, distance*zoom);
      strokeWeight(1);
      pushMatrix();
      translate(txtSize.y/2 + postxt.x*zoom, postxt.y*zoom);
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

  void updateDist(float dist) {
    distance = dist;
    switch(dimension) {
    case "x": 
      postxt =  new PVector(distance/2,0); 
      break;
    case "y": 
      postxt = new PVector(currentEye.getPos().x, currentEye.getPos().z); 
      break;
    case "z": 
      postxt =  new PVector(currentEye.getPos().x, distance/2); 
      break;
    }
  }

  public boolean clicked(float x, float y){
    if(isOver(x,y)){
      println("clicked");
      return true;
    }
    return false;
  }

  public boolean isOver(float x, float y) {
    //println("----- " + dimension + " -----");
    //print("x: " + x+ ">=" + (postxt.x*zoom - txtSize.x/2 + screenPos.x));
    //println(", " + x + "<=" + (postxt.x*zoom + txtSize.x/2 + screenPos.x));
    //print("y: " + y + ">=" + (postxt.y*zoom - txtSize.y/2 + screenPos.y));
    //println( ", " + y + "<=" + (postxt.y*zoom + txtSize.y/2 + screenPos.y));
    return x >= postxt.x*zoom - txtSize.x/2 + screenPos.x && x <= postxt.x*zoom + txtSize.x/2 + screenPos.x && y >= postxt.y*zoom - txtSize.y/2 + screenPos.y && y <= postxt.y*zoom + txtSize.y/2 + screenPos.y;
  }
  
  // roundN(float num, float n){
  //  return float(round(num * n))/n;
  //}
}
