class InputField{
 PVector pos;
 PVector size;
 String input;
 String startTxt;
 
  InputField(String startTxt){
    pos = new PVector(0,height*0.9);
    size = new PVector(width,height*0.1);
    this.startTxt = startTxt;
    input = "";
  }

  void display(){
    fill(255,150);
    rectMode(CORNER);
    rect(pos.x, pos.y, size.x, size.y);
    textAlign(LEFT, CENTER);
    if(input == ""){//no text has been written
      fill(100);
      text(startTxt, pos.x + 200, pos.y + size.y/2);
    } else{
      fill(0);
      text(input, pos.x + 200, pos.y + size.y/2);
    }
  }

  void typed(char pressedKey) {
    
  }
}
