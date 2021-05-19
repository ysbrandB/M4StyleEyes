import peasy.*;
import KinectPV2.KJoint;
import KinectPV2.*;

import processing.net.*;
Server s;
boolean draw= true;
KinectPV2 kinect;
PeasyCam camera;
PVector camPos=new PVector(0, 1.5, 0);
void setup() {

  camera = new PeasyCam(this, -2, 0, -1, 100);
  size(1000, 1000, P3D);

  kinect = new KinectPV2(this);

  // Enable 3d  with (x,y,z) position
  kinect.enableSkeleton3DMap(true);

  kinect.init();

  s = new Server(this, 10001);
  if (draw) {
    ambientLight(255, 255, 255);
    perspective(PI/3.0, width/height, 1, 10000);
    sphereDetail(1);
    rectMode(CENTER);
  }
}

void draw() {
  if (draw) {
    ambientLight(255, 255, 255);
    background(255);
    drawCam(new PVector(0, 1.5, 0));

    pushMatrix();  

    rotateX(PI/2);
    translate(0, 0, -120);
    rect(0, 0, 500, 500);
    popMatrix();
  }
  // Get the 3D data points from the 3D skeleton (access to Z point)
  ArrayList<KSkeleton> skeleton3DArray =  kinect.getSkeleton3d();

  //Make an arraylist for all the heads tracked this frame
  ArrayList<PVector> heads = new ArrayList<PVector>();

  for (int i = 0; i < skeleton3DArray.size(); i++) {
    KSkeleton skeleton3D = (KSkeleton) skeleton3DArray.get(i);
    if (skeleton3D.isTracked()) {
      KJoint[] joints3D = skeleton3D.getJoints();
      PVector[] myJoints= new PVector[joints3D.length];
      for (int j=0; j<joints3D.length; j++) {
        PVector jointPos=new PVector(joints3D[j].getX(), -joints3D[j].getY(), joints3D[j].getZ());
        myJoints[j]=jointPos;
        if (draw) {
          drawPoint(jointPos, j);
          fill(255, 0, 0);
        }
        if (j==3) {
          heads.add(jointPos);
          
        }
      }
      if (draw) {
        drawBody(myJoints);
      }
    }
  }
  if(draw){
  fill(255, 0, 0);
  textSize(10);
  text(frameRate, 50, 50);
  }
  String payload="";
  for (PVector head : heads) {
    payload+=head.x+" "+head.y+" "+head.z+",";
  }
  payload+="\n";
  //(x y z,x y z, x y z,'\n')
  s.write(payload);
  println(payload);
}

PVector lastPoint;
void drawPoint(PVector pos, int j) {
  if (j!=25) {
    pushMatrix();
    PVector drawPos=camPos.copy().add(pos.copy().mult(100));
    translate(drawPos.x, drawPos.y, drawPos.z);
    textSize(2);
    text(j, 4, 0);
    fill(0, 0, 255);
    sphere(2);
    popMatrix();
  }
}

void drawCam(PVector pos) {
  pushMatrix();
  translate(pos.x, -pos.y, pos.z);
  fill(0, 255, 0);
  sphere(5);
  popMatrix();
}

void draw3DLine(PVector pos1, PVector pos2) {
  strokeWeight(3);
  stroke(255, 0, 0);
  PVector drawPos1=camPos.copy().add(pos1.copy().mult(100));
  PVector drawPos2=camPos.copy().add(pos2.copy().mult(100));
  line(drawPos1.x, drawPos1.y, drawPos1.z, drawPos2.x, drawPos2.y, drawPos2.z);
  stroke(0);
  strokeWeight(1);
}

void drawBody(PVector[] myJoints) {
  //leftLeg
  draw3DLine(myJoints[15], myJoints[14]);
  draw3DLine(myJoints[14], myJoints[13]);
  draw3DLine(myJoints[13], myJoints[12]);
  draw3DLine(myJoints[12], myJoints[0]);

  //rightLeg
  draw3DLine(myJoints[19], myJoints[18]);
  draw3DLine(myJoints[18], myJoints[17]);
  draw3DLine(myJoints[17], myJoints[16]);
  draw3DLine(myJoints[16], myJoints[0]);

  //leftArm
  draw3DLine(myJoints[21], myJoints[7]);
  draw3DLine(myJoints[7], myJoints[6]);
  draw3DLine(myJoints[6], myJoints[5]);
  draw3DLine(myJoints[5], myJoints[4]);
  draw3DLine(myJoints[4], myJoints[20]);
  //leftThumb
  draw3DLine(myJoints[22], myJoints[6]);

  //rightArm
  draw3DLine(myJoints[23], myJoints[11]);
  draw3DLine(myJoints[11], myJoints[10]);
  draw3DLine(myJoints[10], myJoints[9]);
  draw3DLine(myJoints[9], myJoints[8]);
  draw3DLine(myJoints[8], myJoints[20]);
  //rightThumb
  draw3DLine(myJoints[24], myJoints[10]);

  //spine
  draw3DLine(myJoints[0], myJoints[1]);
  draw3DLine(myJoints[1], myJoints[20]);
  draw3DLine(myJoints[20], myJoints[2]);
  draw3DLine(myJoints[2], myJoints[3]);
}
