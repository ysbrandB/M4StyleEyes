class DebugNoise {
  PVector pos;
  PVector dir;
  char[] updateKeys;
  DebugNoise(PVector pos) {
    this.pos=pos;
    dir=new PVector(0,0,0);
  }
  void show() {
    heads.add(pos);
    drawPoint(pos, color(255, 0, 255));
    pos.add(dir);
  }
  void changeDirection(int key, boolean pressed) {
    if (pressed) {
      switch(key){
      case 'w': dir.y=-1;break;
      case 's': dir.y=1;break;
      case 'a': dir.x=-1;break;
       case 'd': dir.x=1;break;
      }
      switch(keyCode){
      case UP: dir.y=-1;break;
      case DOWN: dir.y=1;break;
      case LEFT: dir.x=-1;break;
       case RIGHT: dir.x=1;break;
      }
    } else {
      switch(keyCode){
      case UP: dir.y=0;break;
      case DOWN: dir.y=0;break;
      case LEFT: dir.x=0;break;
       case RIGHT: dir.x=0;break;
      }switch(key){
      case 'w': dir.y=0;break;
      case 's': dir.y=0;break;
      case 'a': dir.x=0;break;
       case 'd': dir.x=0;break;
      }
    }
  }
}
