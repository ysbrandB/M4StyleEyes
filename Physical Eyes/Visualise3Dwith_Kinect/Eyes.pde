class Eye {
  int id;
  PVector pos;
  PVector closestHead= kinectPos.copy();
  int angleY, angleZ;
  float closestDist;
  PVector headToEye= kinectPos.copy();
  int neutralYAngle;
  int neutralZAngle;
  Eye(PVector pos, int id) {
    //als het niet het scherm is:
    if (id!=-1) {
      this.id=id;
    }
    this.pos=pos;
    angleY=0;
    angleZ=0;
    //compute the standard angle to kinect
    PVector neutralVector=PVector.sub(kinectPos, pos);    

    PVector neutralY=new PVector(neutralVector.x, neutralVector.z);
    neutralYAngle=int((neutralY.heading())/PI*180);
    if(pos.x<0){
    //to get the degrees from -180 to 180 to 0 to 360 
    neutralYAngle+=180;
    }else if(1==1){}
    PVector neutralZ=new PVector(neutralVector.x, neutralVector.y);
    neutralZAngle=int((neutralZ.heading()+PI)/PI*180);    
  }

  //show the eye and lookingvectorline
  void show() {
    //cheat display of line
    PVector displayLine= headToEye.copy().setMag(30).add(pos);
    draw3DLine(pos, displayLine, color (0, 0, 255));
    drawPoint(pos, color (255, 0, 0));
  }  
  
  
  //update the lookingvector and calculate its angles
  void update() {
    
    closestDist=999999999;
    for (int i=0; i<heads.size(); i++) {
      float distance=PVector.dist(heads.get(i), pos);
      if (distance<closestDist) {
        closestDist=distance;
        closestHead=heads.get(i).copy();
      }
    }
    
    //vector from eye to kinect
    headToEye=PVector.sub(closestHead.copy(), pos.copy());    
    
    PVector lookY=new PVector(headToEye.x, headToEye.z);

    angleY=int((lookY.heading()+PI)/PI*180);
    if (pos.x>0) {
      //println(angleY, neutralYAngle,angleY-neutralYAngle );
    }
    if (pos.x<0) {
      println(angleY, neutralYAngle,neutralYAngle-angleY );
    }

    PVector lookZ=new PVector(headToEye.x, headToEye.y);
    angleZ=int((lookZ.heading()+PI)/PI*180);
  }
}
