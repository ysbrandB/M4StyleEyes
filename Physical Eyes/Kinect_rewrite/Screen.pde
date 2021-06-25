class Screen {
  Eye screenEye;
  PVector pos;
  float physicalScreenWidth;
  Server s;
  boolean screenFollowMultiplePeople=true;
  Screen(PApplet context, JSONObject setupData, PVector kinectPos) {
    JSONObject screenData= setupData.getJSONObject("Screen");
    pos=new PVector(screenData.getFloat("x"), screenData.getFloat("y"), screenData.getFloat("z"));
    physicalScreenWidth=screenData.getInt("screenWidth");

    //setup the TCP server
    s = new Server(context, 10001);

    screenEye=new Eye(pos, -1, kinectPos);
  }
  void show() {
    screenEye.show();
    //draw the line where the screen is
    draw3DLine(new PVector(pos.x+physicalScreenWidth/2, pos.y, pos.z), new PVector(pos.x-physicalScreenWidth/2, pos.y, pos.z), color(0, 0, 0));
  }

  void update() {// update the lookingvector of the screen
    screenEye.update();
    if (screenFollowMultiplePeople) {
      //send all the heads to interface
      String TCPPayload="";
      for (PVector head : heads) {
        PVector adjustedLookingPos=PVector.sub(head, screen.pos);
        TCPPayload+=""+adjustedLookingPos.x+","+adjustedLookingPos.y+","+adjustedLookingPos.z+"|";
      }
      if (TCPPayload.length()>0) {
        //delete the last |
        if ( TCPPayload.charAt( TCPPayload.length()-1) == '|' ) {
          TCPPayload = TCPPayload.substring( 0, TCPPayload.length()-1 );
        }
        TCPPayload+='\n';
        s.write(TCPPayload);
      } else {
        //send just the closest head to interface
        //Adjust the lookingPos for the screen by the difference between kinect and screenmid
        //send the lookingvector over TCP to the eyeSketch
        PVector adjustedLookingPos=PVector.sub(screenEye.closestHead, screen.pos);
        String TCPpayload=""+adjustedLookingPos.x+","+adjustedLookingPos.y+","+adjustedLookingPos.z+"\n";
        //(x,y,z,'\n')
        //write the coords to the drawing sketch
        s.write(TCPpayload);
      }
    }
  }
  float getHalfPhysicalScreenWidth() {
    return (physicalScreenWidth/2);
  }
}
