<<<<<<< Updated upstream:ConceptEyesWithPupil/OnlyEyesMake/OnlyEyesMake.pde
<<<<<<< HEAD
=======
>>>>>>> Stashed changes:ConceptEyes/OnlyEyesMake/OnlyEyesMake.pde
//FAILED IMPLEMENTATION
//PImage eyeIris;
//void setup() {
//  imageMode(CENTER);
//  background(255,255,255,255);
//  eyeIris = loadImage("../data/eyeIris.png");
//  size(1840, 1840);
//}


//void draw() {
//  for (int i=0; i<50; i++) {
//    colorMode(HSB, 255);
//    color eyeColor = color(random(75, 175), random(100, 255), random(200, 255));
//    tint(eyeColor);
//    image(eyeIris, width/2, height/2);
//    noTint();
//    String path="../onlyEyes/eye"+i+".png";
//    save(path);
//  }
//  noLoop();
//}


//TOTAL IMPLEMENTATION FOR MAKING NEW TRANSPARENT EYES
//PImage[] eyeIrissen=new PImage[50];
//PImage eyeIris;
//void setup() {
//  imageMode(CENTER);
//  background(255, 255, 255, 255);
//  eyeIris = loadImage("../data/eyeIris.png");
//  size(1840, 1840);

//  for (int i=0; i<50; i++) {
//    colorMode(HSB, 255);
//    color eyeColor = color(random(75, 175), random(100, 255), random(200, 255));
//    tint(eyeColor);
//    image(eyeIris, width/2, height/2);
//    noTint();
//    String path="../onlyEyes/eye"+i+".png";
//    save(path);
//  }

//  for (int i=0; i<50; i++) {
//    String path="../onlyEyes/eye"+i+".png";
//    eyeIrissen[i]=loadImage(path);
//    eyeIrissen[i].format=ARGB;
//  }
//  colorMode(RGB);
//}


//void draw() {
//  for (int i=0; i<eyeIrissen.length; i++) {
//    for (int j=0; j<eyeIrissen[i].pixels.length; j++) {
//      if (eyeIrissen[i].pixels[j]==color(255, 255, 255)) {
//        eyeIrissen[i].pixels[j]=color(0, 0, 0, 0);
//      }
//    }
//  }
//  print("saving!");
//  for (int j=0; j<eyeIrissen.length; j++) {
//    String path="../onlyEyes/eye"+j+".png";
//    eyeIrissen[j].save(path);
//  }
//  print("done!");
//  noLoop();
//}


//MIDEYE

//PImage eyeIris;
//void setup() {
//  imageMode(CENTER);
//  background(255, 255, 255, 255);
//  eyeIris = loadImage("../data/eyeIris.png");
//  size(1840, 1840);

//    //colorMode(HSB, 255);
//    color eyeColor = color(255,0,0);
//    tint(eyeColor);
//    image(eyeIris, width/2, height/2);
//    noTint();
//    String path="../data/centerEyeIris.png";
//    save(path);
    

//    eyeIris=loadImage(path);
//    eyeIris.format=ARGB;
//  colorMode(RGB);
//}


//void draw() {
//    for (int j=0; j<eyeIris.pixels.length; j++) {
//      if (eyeIris.pixels[j]==color(255, 255, 255)) {
//        eyeIris.pixels[j]=color(0, 0, 0, 0);
//      }
//  }
//  print("saving!");
//    String path="../data/centerEyeIris.png";
//    eyeIris.save(path);
//  print("done!");
//  noLoop();
//}
<<<<<<< Updated upstream:ConceptEyesWithPupil/OnlyEyesMake/OnlyEyesMake.pde
=======
//FAILED IMPLEMENTATION
//PImage eyeIris;
//void setup() {
//  imageMode(CENTER);
//  background(255,255,255,255);
//  eyeIris = loadImage("../data/eyeIris.png");
//  size(1840, 1840);
//}


//void draw() {
//  for (int i=0; i<50; i++) {
//    colorMode(HSB, 255);
//    color eyeColor = color(random(75, 175), random(100, 255), random(200, 255));
//    tint(eyeColor);
//    image(eyeIris, width/2, height/2);
//    noTint();
//    String path="../onlyEyes/eye"+i+".png";
//    save(path);
//  }
//  noLoop();
//}


//TOTAL IMPLEMENTATION FOR MAKING NEW TRANSPARENT EYES
//PImage[] eyeIrissen=new PImage[50];
//PImage eyeIris;
//void setup() {
//  imageMode(CENTER);
//  background(255, 255, 255, 255);
//  eyeIris = loadImage("../data/eyeIris.png");
//  size(1840, 1840);

//  for (int i=0; i<50; i++) {
//    colorMode(HSB, 255);
//    color eyeColor = color(random(75, 175), random(100, 255), random(200, 255));
//    tint(eyeColor);
//    image(eyeIris, width/2, height/2);
//    noTint();
//    String path="../onlyEyes/eye"+i+".png";
//    save(path);
//  }

//  for (int i=0; i<50; i++) {
//    String path="../onlyEyes/eye"+i+".png";
//    eyeIrissen[i]=loadImage(path);
//    eyeIrissen[i].format=ARGB;
//  }
//  colorMode(RGB);
//}


//void draw() {
//  for (int i=0; i<eyeIrissen.length; i++) {
//    for (int j=0; j<eyeIrissen[i].pixels.length; j++) {
//      if (eyeIrissen[i].pixels[j]==color(255, 255, 255)) {
//        eyeIrissen[i].pixels[j]=color(0, 0, 0, 0);
//      }
//    }
//  }
//  print("saving!");
//  for (int j=0; j<eyeIrissen.length; j++) {
//    String path="../onlyEyes/eye"+j+".png";
//    eyeIrissen[j].save(path);
//  }
//  print("done!");
//  noLoop();
//}


//MIDEYE

//PImage eyeIris;
//void setup() {
//  imageMode(CENTER);
//  background(255, 255, 255, 255);
//  eyeIris = loadImage("../data/eyeIris.png");
//  size(1840, 1840);

//    //colorMode(HSB, 255);
//    color eyeColor = color(255,0,0);
//    tint(eyeColor);
//    image(eyeIris, width/2, height/2);
//    noTint();
//    String path="../data/centerEyeIris.png";
//    save(path);
    

//    eyeIris=loadImage(path);
//    eyeIris.format=ARGB;
//  colorMode(RGB);
//}


//void draw() {
//    for (int j=0; j<eyeIris.pixels.length; j++) {
//      if (eyeIris.pixels[j]==color(255, 255, 255)) {
//        eyeIris.pixels[j]=color(0, 0, 0, 0);
//      }
//  }
//  print("saving!");
//    String path="../data/centerEyeIris.png";
//    eyeIris.save(path);
//  print("done!");
//  noLoop();
//}
>>>>>>> master
=======
>>>>>>> Stashed changes:ConceptEyes/OnlyEyesMake/OnlyEyesMake.pde
