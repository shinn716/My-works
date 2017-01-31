float x;
float y;
float easing = 0.05;

void setup() {
  size(640, 360); 
  noStroke();  
  x=width/2;
  y=height/2;
}

void draw() {
  fill(0, 50); 
  rect(0, 0, width, height);
  
  float targetX = mouseX;
  float dx = targetX - x;
  x += dx * easing;
  
  float targetY = mouseY;
  float dy = targetY - y;
  y += dy * easing;
  fill(255);
  ellipse(x, y, 66, 66);
}