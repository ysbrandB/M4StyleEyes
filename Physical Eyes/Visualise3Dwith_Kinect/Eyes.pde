class Eye {
  int id;
  PVector pos;
  PVector closestHead= camPos.copy();
  float angleY, angleZ;
  float closestDist;
  PVector headToEye= new PVector(0,0,0);
  Eye(PVector pos, int id) {
    //als het niet het scherm is:
    if(id!=-1){
    this.id=id;
    }
    this.pos=pos;
    angleY=0;
    angleZ=0;
  }
//show the eye and lookingvectorline
  void show() {
    //cheat display of line
    PVector displayLine= headToEye.copy().setMag(30).add(pos);
    draw3DLine(pos, displayLine, color (0,0,255));
    drawPoint(pos, color (255,0,0));
  }  
  //update the lookingvector and calculate its angles
  void update(){
    closestDist=999999999;
    for (int i=0; i<heads.size(); i++) {
      float distance=PVector.dist(heads.get(i), pos);
      if (distance<closestDist) {
        closestDist=distance;
        closestHead=heads.get(i).copy();
      }
    }
    headToEye=PVector.sub(closestHead.copy(), pos.copy());    
    
    PVector lookY=new PVector(headToEye.x, headToEye.z);
    angleY=(-lookY.heading())/PI*180;

    PVector lookZ=new PVector(headToEye.x, headToEye.y);
    angleZ=(lookZ.heading())/PI*180;
  }
}
