class Button {
  /*
    The button class, this class makes buttons that you can click on.
    Exampels are: Reset button, Revive button, Close button. 
  */
  PVector pos;
  PVector size;
  color colorbg;
  String text;
  int timer;
  boolean isClicked;
  int textsize;
  final color colorRest = color(150);
  final color colorHover = color(130);
  static final int bend = 10;


  Button(float x, float y, float Width, float Height, String textIn, int textsizeIn) {
    pos = new PVector(x, y);
    size = new PVector(Width, Height);
    text = textIn;
    isClicked = false;
    textsize = textsizeIn;
  }

  void display() {
    fill(colorbg);
    stroke(0);
    rect(pos.x, pos.y, size.x, size.y, bend, bend, bend, bend);
    fill(0);
    textSize(textsize);
    textAlign(CENTER);
    text(text, pos.x+size.x/2, pos.y+size.y/3*2);
  }

  void update(float x, float y) {
    if (isOver(x, y)) colorbg = colorHover; //if you hover over it with your mouse, change color.
    else colorbg = colorRest;

    //clicked animation.
    if (isClicked) {
      timer -=5;
      if (timer >= 50) colorbg = color(255, map(timer, 100, 50, 0,150));
      else if (timer>0) colorbg = color(255, map(timer, 50, 0, 150,0));
      else isClicked = false;
    }
  }

  void clicked(float x, float y) {
    if (isOver(x,y)) {
      timer = 100;
      isClicked = true;
    }
  }

  boolean isOver(float x, float y) {
    return (x>=pos.x && x<=pos.x+size.x) && (y>=pos.y && y<=pos.y+size.y);
  }
}
