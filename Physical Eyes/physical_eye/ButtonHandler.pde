interface ClickFunction {
  void clicked();
}


class ButtonHandler {
  Button addEyeBtn;
  AddEyeClick addEyeClick;

  ButtonHandler() {
    addEyeClick = new AddEyeClick();
    addEyeBtn = new Button(width*0.78, height*0.88, width*0.2, height*0.1, "Add eye", 20, addEyeClick);
  }

  public void update(){
    
  }
  
  public void display(){
    addEyeBtn.display();
  }
  
  public void clicked(){
    
  }
  class AddEyeClick implements ClickFunction {
    public void clicked() {
    }
  }
}
