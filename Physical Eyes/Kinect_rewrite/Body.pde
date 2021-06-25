class Body {
  PVector head;
  PVector[] joints;
  Body(PVector[] joints, PVector head) {
    this.head=head;
    this.joints=joints;
  }
  //draw all the bones between the joints
  void show() {
    for (int i=0; i<joints.length; i++) {
      //draw the joints
      if (i!=25) {
        drawPoint(joints[i], color(255, 0, 0));
      }
    }

    color someColor;
    if (!triggeredInterface) {
      someColor=color(0, 0, 255);
    } else {
      someColor=color(255, 0, 255);
    }
    //leftLeg
    draw3DLine(joints[15], joints[14], someColor);
    draw3DLine(joints[14], joints[13], someColor);
    draw3DLine(joints[13], joints[12], someColor);
    draw3DLine(joints[12], joints[0], someColor);

    //rightLeg
    draw3DLine(joints[19], joints[18], someColor);
    draw3DLine(joints[18], joints[17], someColor);
    draw3DLine(joints[17], joints[16], someColor);
    draw3DLine(joints[16], joints[0], someColor);

    //leftArm
    draw3DLine(joints[21], joints[7], someColor);
    draw3DLine(joints[7], joints[6], someColor);
    draw3DLine(joints[6], joints[5], someColor);
    draw3DLine(joints[5], joints[4], someColor);
    draw3DLine(joints[4], joints[20], someColor);
    //leftThumb
    draw3DLine(joints[22], joints[6], someColor);

    //rightArm
    draw3DLine(joints[23], joints[11], someColor);
    draw3DLine(joints[11], joints[10], someColor);
    draw3DLine(joints[10], joints[9], someColor);
    draw3DLine(joints[9], joints[8], someColor);
    draw3DLine(joints[8], joints[20], someColor);
    //rightThumb
    draw3DLine(joints[24], joints[10], someColor);

    //spine
    draw3DLine(joints[0], joints[1], someColor);
    draw3DLine(joints[1], joints[20], someColor);
    draw3DLine(joints[20], joints[2], someColor);
    draw3DLine(joints[2], joints[3], someColor);
  }
}
