class MyKinect {
  KinectPV2 kinect;  
  PVector pos;
  MyKinect(PApplet context, JSONObject setUpData) {
    //init the kinect
    kinect = new KinectPV2(context);
    // Enable 3d  with (x,y,z) position
    kinect.enableSkeleton3DMap(true);
    kinect.init();
    JSONObject kinectData= setUpData.getJSONObject("Kinect");
    pos=new PVector(kinectData.getFloat("x"), kinectData.getFloat("y"), kinectData.getFloat("z"));
  }
  void show() {
    //draw kinect
    drawPoint(pos, color (0, 255, 0));
  }
  PVector getPos() {
    return pos.copy();
  }
  void updateBodies() {
    // Get the 3D data points from the 3D skeleton (access to Z point)
    ArrayList<KSkeleton> skeleton3DArray =  kinect.getSkeleton3d();
    for (int i = 0; i < skeleton3DArray.size(); i++) {
      KSkeleton skeleton3D = (KSkeleton) skeleton3DArray.get(i);
      if (skeleton3D.isTracked()) {
        KJoint[] joints3D = skeleton3D.getJoints();
        PVector[] myJoints= new PVector[joints3D.length];
        //add every joint to the arraylist to draw and every head to the heads arraylist
        for (int j=0; j<joints3D.length; j++) {
          PVector jointPos=new PVector(joints3D[j].getX()*100, -joints3D[j].getY()*100, joints3D[j].getZ()*100);
          myJoints[j]=pos.copy().add(jointPos.copy());
        }
        bodies.add(new Body(myJoints, myJoints[3]));
        heads.add(myJoints[3]);
      }
    }
  }
}
