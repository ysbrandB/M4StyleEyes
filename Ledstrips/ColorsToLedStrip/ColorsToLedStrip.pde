import processing.serial.*; // import the library
 
Serial port; // make the port object

PVector red   = new PVector(0,-1);
PVector green = PVector.fromAngle(radians(30));
PVector blue  = PVector.fromAngle(radians(180-30));
float size = width/3;
float step = 5;
float min = 0;
float max = 255;

void setup(){
    size(1000,1000);

    red   = new PVector(0,-1);
    green = PVector.fromAngle(radians(30));
    blue  = PVector.fromAngle(radians(180-30));
    size = width/5;
    step = 5;
    
    port = new Serial(this, Serial.list()[0], 9600);  // open the port!
}

void draw(){
    

    float distance = dist(mouseX, mouseY, width/2, height/2);
    // if(distance >= size*1.5) distance = size*1.5;
    PVector mouse = new PVector(mouseX - width/2, mouseY - height/2);
    float redValue = map(distance * cos(PVector.angleBetween(mouse, red)), 0, size, 0, 255);
    float greenValue = map(distance * cos(PVector.angleBetween(mouse, green)), 0, size, 0, 255);
    float blueValue = map(distance * cos(PVector.angleBetween(mouse, blue)), 0, size, 0, 255);
    
    if (redValue < 0 || redValue > 255) redValue = redValue < 0 ? 0 : 255;
    if (greenValue < 0 || greenValue > 255) greenValue = greenValue < 0 ? 0 : 255;
    if (blueValue < 0 || blueValue > 255) blueValue = blueValue < 0 ? 0 : 255;

    color kleurtje = color(redValue, greenValue, blueValue);
    String payload = int(redValue) + "," + int(greenValue) + "," + int(blueValue) + ",";
    port.write(payload);
    println(payload);
    
    background(kleurtje);

    noStroke();
    pushMatrix();
    translate(width/2, height/2);
    //right triangle
    for(float r = 0; r < size; r += step*0.85){
        for(float g = 0; g < size; g += step*0.85){
            PVector place = PVector.add(red.copy().setMag(r), green.copy().setMag(g));

            fill(map(r, 0, size, min, max), map(g, 0, size, min, max), 0);
            rect(place.x, place.y, step, step);
        }
    }
    //bottom triangle
    for(float g = 0; g < size; g += step*0.85){
        for(float b = 0; b < size; b += step*0.85){
            PVector place = PVector.add(green.copy().setMag(g), blue.copy().setMag(b));

            fill(0, map(g, 0, size, min, max), map(b, 0, size, min, max));
            rect(place.x, place.y, step, step);
        }
    }
    //left triangle
    //bottom triangle
    for(float b = 0; b < size; b += step*0.85){
        for(float r = 0; r < size; r += step*0.85){
            PVector place = PVector.add(blue.copy().setMag(b), red.copy().setMag(r));

            fill(map(r, 0, size, min, max), 0, map(b, 0, size, min, max));
            rect(place.x, place.y, step, step);
        }
    }

    rotate(radians(30));
    beginShape();
    noFill();
    stroke(kleurtje);
    strokeWeight(10);
    for (int i = 1; i<=6; i++) {
      vertex(size*cos((2*PI)/6 * i), size * sin((2*PI)/6 * i));
    }
    endShape(CLOSE);

    popMatrix();
}
