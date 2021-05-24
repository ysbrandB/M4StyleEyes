class Eye{
    PVector pos;
    PVector size;
    float radius = 30;//temp
    PImage img;
    boolean isSelected;
    boolean moveSelected;
    boolean hover;
    DistanceMeter distX;
    DistanceMeter distY;
    DistanceMeter distZ;
    
    Eye(float x, float y, float z, PImage img){
      pos = new PVector(x,y,z);
      isSelected = false;
      moveSelected = false;
      this.img = img;
      
      distX = new DistanceMeter(pos.x, this, "x");
      distY = new DistanceMeter(pos.y, this, "y");
      distZ = new DistanceMeter(pos.z, this, "z");
    }
    
    void display(){
      //fill(0);
      //circle(pos.x,pos.z, radius);
      
      if(hover) tint(200);
      image(img, pos.x*zoom,pos.z*zoom);
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

    void dragged(float x, float z){
      if(moveSelected){
         pos = new PVector(x,0,z).sub(new PVector(screenPos.x, 0 , screenPos.y));
         distX.updateDist(pos.x);
         distY.updateDist(pos.y);
         distZ.updateDist(pos.z);
      }
    }
        
    void select(float x, float z){
     if(isOver(x,z)){
       if(isSelected) moveSelected = true;
       isSelected = true;
     } else if(!distX.clicked(x,z) && !distY.clicked(x,z) && !distZ.clicked(x,z)){
       isSelected = false;
       moveSelected = false;
      }
    }
    
    boolean isOver(float x, float z){
     return dist(x, z, pos.x*zoom + screenPos.x, pos.z*zoom + screenPos.y) <= radius;
    }
    PVector getPos(){
     return pos.copy(); 
    }

    void mouseRelease(){
      moveSelected = false;
    }
}
