class InputColor{
    PVector red   = new PVector(0, -1);
    PVector green = PVector.fromAngle(radians(30));
    PVector blue  = PVector.fromAngle(radians(180-30));
    float size = width/3;
    float step = 5;
    float min = 0;
    float max = 255;

    InputColor(){
        red   = new PVector(0, -1);
        green = PVector.fromAngle(radians(30));
        blue  = PVector.fromAngle(radians(180-30));
        size = width/3;
        step = 5;
    }

    void display(){
        // color colorKleurtje = color(map(redValue, 0, size, 0, 255), map(greenValue, 0, size, 0, 255), map(blueValue, 0, size, 0, 255));
        background(getColor());

        noStroke();
        pushMatrix();
        translate(width/2, height/2);
        //right triangle
        for (float r = 0; r < size; r += step*0.85) {
            for (float g = 0; g < size; g += step*0.85) {
            PVector place = PVector.add(red.copy().setMag(r), green.copy().setMag(g));

            fill(map(r, 0, size, min, max), map(g, 0, size, min, max), 0);
            rect(place.x, place.y, step, step);
            }
        }
        //bottom triangle
        for (float g = 0; g < size; g += step*0.85) {
            for (float b = 0; b < size; b += step*0.85) {
            PVector place = PVector.add(green.copy().setMag(g), blue.copy().setMag(b));

            fill(0, map(g, 0, size, min, max), map(b, 0, size, min, max));
            rect(place.x, place.y, step, step);
            }
        }
        //left triangle
        //bottom triangle
        for (float b = 0; b < size; b += step*0.85) {
            for (float r = 0; r < size; r += step*0.85) {
            PVector place = PVector.add(blue.copy().setMag(b), red.copy().setMag(r));

            fill(map(r, 0, size, min, max), 0, map(b, 0, size, min, max));
            rect(place.x, place.y, step, step);
            }
        }

        rotate(radians(30));
        beginShape();
        noFill();
        stroke(getColor());
        strokeWeight(10);
        for (int i = 1; i<=6; i++) {
            vertex(size*cos((2*PI)/6 * i), size * sin((2*PI)/6 * i));
        }
        endShape(CLOSE);

        popMatrix();
    }

    color getColor(){
        colorMode(RGB);
        //deterimins the color of the mouse.
        float distance = dist(mouseX, mouseY, width/2, height/2);
        PVector mouse = new PVector(mouseX - width/2, mouseY - height/2);
        float redValue = distance * cos(PVector.angleBetween(mouse, red));
        float greenValue = distance * cos(PVector.angleBetween(mouse, green));
        float blueValue = distance * cos(PVector.angleBetween(mouse, blue));
        return color(redValue, greenValue,blueValue);
    }
}