class Calibration {
  ArrayList<Eye> eyes = new ArrayList<Eye>();
  JSONArray eyePosData;

  Calibration(JSONArray eyePosData) {
    this.eyePosData = eyePosData;

  int i = 0;
    //for (int i = 0; i < eyePosData.size(); i++) {
      JSONObject eye = eyePosData.getJSONObject(i);
      eyes.add(new Eye(eye.getFloat("x"), eye.getFloat("y"), eye.getFloat("z"), eyeImg));
    //}
  }

  void update(float x, float z) {
    for (Eye eye : eyes) {
      eye.update(x, z);
    }
  }

  void display() {
    for (Eye eye : eyes) {
      eye.display();
    }
  }
  
  void clicked(float x, float z){
    for (Eye eye : eyes) {
      eye.select(x,z);
    }
  }

  void dragged(float x, float z){
    for (Eye eye : eyes) {
      eye.dragged(x,z);
    }
  }

   void mouseRelease(){
     for (Eye eye : eyes) {
      eye.mouseRelease();
    }
   }
}
