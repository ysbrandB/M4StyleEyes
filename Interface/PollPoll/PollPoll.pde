Poll poll;


void setup() {
  size(350, 200);
  poll = new Poll(new PVector(0, 0));
}

void draw() {
  background(0);
  poll.display();
  
}
