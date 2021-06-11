class Button {
  /*
    The button class, this class makes buttons that you can click on.
  */
  PVector pos;
  PVector size;
  color colorbg;
  String text;
  int timer;
  boolean isClicked;
  int textsize;
  final color colorRest = color(160);
  final color colorHover = color(140);
  final color colorClicked = color(100);
  static final int bend = 10;
  ClickFunction clickFunction;


  Button(float x, float y, float Width, float Height, String textIn, int textsizeIn, ClickFunction clickFunction) {
    pos = new PVector(x, y);
    size = new PVector(Width, Height);
    text = textIn;
    isClicked = false;
    textsize = textsizeIn;
    if(textsize <= 0){
      textSize(1);
      textsize = int(Width/textWidth(textIn));
      if(textsize > Height-10) textsize = int(Height-10);
    }

    this.clickFunction = clickFunction;
    colorbg = colorRest;
  }

  void display() {
    rectMode(CORNER);
    fill(colorbg);
    stroke(0);
    rect(pos.x, pos.y, size.x, size.y, bend, bend, bend, bend);
    fill(0);
    textSize(textsize);
    textAlign(CENTER,CENTER);
    text(text, pos.x+size.x/2, pos.y+size.y/2 - textDescent()*0.4);
  }

  void update(float x, float y) {
    if (isOver(x, y)) colorbg = colorHover; //if you hover over it with your mouse, change color.
    else colorbg = colorRest;

    //clicked animation.
    if (isClicked) {
      timer -=5;
      if (timer >= 50) colorbg = lerpColor(colorClicked, colorHover, map(timer, 50, 100, 0, 1));//color(255, map(timer, 100, 50, 0,150));
      else if (timer>0) colorbg = lerpColor(colorHover, colorClicked, map(timer, 0, 50, 0, 1));//color(255, map(timer, 50, 0, 150,0));
      else isClicked = false;
    }
  }

  void clicked(float x, float y) {
    if (isOver(x,y) && !isClicked) {
      timer = 100;
      isClicked = true;
      clickFunction.clicked();
    }
  }

  boolean isOver(float x, float y) {
    return (x>=pos.x && x<=pos.x+size.x) && (y>=pos.y && y<=pos.y+size.y);
  }
}
