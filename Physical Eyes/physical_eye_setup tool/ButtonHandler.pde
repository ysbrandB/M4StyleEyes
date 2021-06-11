interface ClickFunction {
  void clicked();
}


class ButtonHandler {
  Button safeBtn;
  SafeBtnClick safeBtnClick;

  ButtonHandler() {
    safeBtnClick = new SafeBtnClick();
    safeBtn = new Button(width/2-width*0.15, height*0.88, width*0.3, height*0.1, "Save", 50, safeBtnClick);
  }

  public void update(float x, float y){
    safeBtn.update(x,y);
  }
  
  public void display(){
    safeBtn.display();
  }
  
  public void clicked(float x, float y){
    safeBtn.clicked(x,y);
  }
  class SafeBtnClick implements ClickFunction {
    public void clicked() {
      safe();
    }
  }
}
