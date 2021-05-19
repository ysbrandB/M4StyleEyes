class Eye{
    PVector pos;
    PVector size;
    float radius = 50;//temp
    PImage img;
    boolean isSelected;
    boolean hover;
    DistanceMeter distX;
    DistanceMeter distY;
    DistanceMeter distZ;
    
    Eye(float x, float y, float z, PImage img){
      pos = new PVector(x,y,z);
      isSelected = false;
      this.img = img;
      
      distX = new DistanceMeter(pos.x, this, "x");
      distY = new DistanceMeter(pos.y, this, "y");
      distZ = new DistanceMeter(pos.z, this, "z");
    }
    
    void display(){
      //fill(0);
      //circle(pos.x,pos.z, radius);
      
      if(hover) tint(200);
      image(img, pos.x,pos.z);
      tint(255);
      
      if(isSelected){
      distX.display();
      distY.display();
      distZ.display();
      }
    }
    
    void update(float x, float z){
      if(isOver(x,z)) hover = true;
      else hover = false;
    }
    
    void showDistances(){
      
    }
    
    void select(float x, float z){
     if(isOver(x,z)) isSelected = !isSelected;
    }
    
    boolean isOver(float x, float z){
     return dist(x, z, pos.x + screenPos.x, pos.z + screenPos.y) <= radius;
    }
    PVector getPos(){
     return pos.copy(); 
    }
}
