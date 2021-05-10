let amount = 10000;
let eyes = [];
let loadSeconds;
let personDistance = 200;
let timeElapsed = 0;
let maxTime = 200;
let personPos;
function setup() {
  personPos=createVector(mouseX,mouseY,100);
  //fullscreen(true);
  createCanvas(innerWidth, innerHeight);
  area = width * height;
  background(0);
  eyes.push(new Eye(false));
  eyes.push(new Eye(true));
  for (let i = 0; i < amount; i++) {
    eyes.push(new Eye(false));
    if (timeElapsed > maxTime) {
      eyes.pop();
      break;
    }
    timeElapsed = 0;
  }
  console.log(eyes.length);
}

function draw() {
  personPos=createVector(mouseX,mouseY,100);
  background(0);
  for (let i = 1; i < eyes.length; i++) {
    eyes[i].update(personPos);
    eyes[i].show();
  }
}

class Eye {
  constructor(midEye) {
    this.midEye=midEye;
    if (this.midEye) {
      this.pos=createVector(width/2,height/2);
      this.posPupil = this.pos.copy();
      this.r=150;
      this.color = color(255,0,0);
      return;
    }
    colorMode(HSB, 255);
    this.color = color(random(75, 175), random(100, 255), random(200, 255));
    colorMode(RGB);
    this.pos = createVector(random(width), random(height));
    this.posPupil = this.pos.copy();
    this.r = random(10, 50);
    for (let i = 0; i < eyes.length; i++) {
      if (dist(this.pos.x, this.pos.y, eyes[i].pos.x, eyes[i].pos.y) < this.r + eyes[i].r + 2) {
        this.pos = createVector(random(width), random(height));
        this.posPupil = this.pos.copy();
        this.r = random(10, 50);
        timeElapsed++;
        if (timeElapsed > maxTime) {
          return;
        }
        i = 0;
      }
    }
  }

  show() {
    strokeWeight(1);
    fill(255);
    circle(this.pos.x, this.pos.y, this.r * 2);
    colorMode(HSB, 255);
    fill(this.color);
    circle(this.posPupil.x, this.posPupil.y, this.r);
    colorMode(RGB);
    fill(0);

    circle(this.posPupil.x, this.posPupil.y, this.r / 2);
    strokeWeight(15);
    if(this.midEye){strokeWeight(50);}
    noFill();
    circle(this.pos.x, this.pos.y, this.r * 2);
  }
  update(personPos) {
    this.eyeToPerson = createVector(personPos.x, personPos.y, personPos.z).sub(this.pos);
    this.eyeToPerson.setMag(this.r * 0.6);
    this.posPupil = createVector(this.eyeToPerson.x, this.eyeToPerson.y).add(this.pos);
  }
}