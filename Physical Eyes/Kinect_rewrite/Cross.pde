class Cross {
  PVector pos;
  float minimumDistToCross, desiredBufferTime;
  Server s;
  int buffer=0;
  Cross(PApplet context, JSONObject setUpData) {
    JSONObject crossData= setUpData.getJSONObject("Cross");
    pos= new PVector (crossData.getFloat("x"), crossData.getFloat("y"), crossData.getFloat("z"));
    minimumDistToCross=crossData.getFloat("minimumDistance");
    desiredBufferTime=crossData.getInt("bufferFrames");
    s=new Server(context, 10000);
  }
  
  void show() {
    //draw CrossPosition
    drawPoint(pos, color (255, 0, 255));
  }
  void update() {
    float closestDist=999999999;
    for (PVector head : heads) {
      float distance=dist(pos.x, pos.z, head.x, head.z);
      if (distance<closestDist) {
        closestDist=distance;
      }
    }

    if (closestDist<=minimumDistToCross) {
      if (!triggeredInterface) {
        s.write("Start"+'\n');
        print("Start"+'\n');
        triggeredInterface=true;
      }
    } else {
      buffer++;
      if (buffer>desiredBufferTime) {
        triggeredInterface=false;
        buffer=0;
      }
    }
  }
}
