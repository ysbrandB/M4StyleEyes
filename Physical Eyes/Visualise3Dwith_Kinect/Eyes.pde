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
    this.id=id;
    this.pos=pos;
    angleY=0;
    angleZ=0;
    //compute the standard angle to kinect
    PVector neutralVector=PVector.sub(kinectPos, pos);    

    PVector neutralY=new PVector(neutralVector.x, neutralVector.z);
    neutralYAngle=int((neutralY.heading())/PI*180);
    if (pos.x<0) {
      //to get the degrees from -180 to 180 to 0 to 360 
      neutralYAngle+=180;
    } else if (pos.x>0) {
      if (neutralYAngle<0) {
        neutralYAngle=360+neutralYAngle;
      }
    }
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


    if (pos.x<0) {
      angleY=int((lookY.heading()+PI)/PI*180);
      angleY=180-(angleY-neutralYAngle);
      //println("LEFT:"+ angleY);
    }
    if (pos.x>0) {
      angleY=int((lookY.heading())/PI*180);
      if (angleY<0) {
        angleY=360+angleY;
      }
      angleY=neutralYAngle-angleY;
      //println("RIGHT:"+ angleY);
    }

    PVector lookZ=new PVector(headToEye.x, headToEye.y);
    if (pos.x>0) {
      angleZ=int((lookZ.heading())/PI*180);
      if (angleZ<0) {
        angleZ=360+angleZ;
      }
      angleZ-=90;
    }
    else if (pos.x<0) {
      angleZ=int((lookZ.heading()+PI)/PI*180);
      if (angleZ<0) {
        angleZ=360+angleZ;
      }
      angleZ=(angleZ-90);
    }
    
  }
}
