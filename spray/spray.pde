float x;
float y; 
float px;
float py;
float easing = 0.2;
float weight= 80;
boolean bg=false;
boolean once=false;

void setup() {
  size(640, 360); 
  stroke(0);
  smooth();
}

void draw() { 
  //line(0, 10, width, 50);
  //Line(0, 10, width, 50);
  //background(51);

  if (bg) {
    fill(255, 200);
    noStroke();
    rect(0, 0, width, height);
  } else {
  }



  if (mousePressed) {
    //if (once==false) {
    //  once=true;
    //  x = mouseX;
    //  y = mouseY;
    //} else {

    //}

    x += (mouseX-x) * easing;
    y += (mouseY-y) * easing;
    
    //println(dist(x, y, px, py));
    if (dist(x, y, px, py)>10) {
      if (weight<5) {
        weight=5;
      } else {
        weight = weight/1.1;
      }
    } else {

      if (weight>30) {
        weight=30;
      } else {
        weight++;
      }
    }

    //float weight = dist(x, y, px, py);
    strokeWeight(weight);
    float _color = map(weight, 0, 30, 0, 100);
    stroke(_color, 100);
    //line(x, y, px, py);
    //ellipse(x, y, weight, weight);
    Line(x, y, px, py, 100);

    py = y;
    px = x;
  } else {
    once=false;
  }
}

//Line Algorithm
void Line(float x1, float y1, float x2, float y2, int pitch)
{
  int i=0;
  while (i<pitch) {
    float tmpx = (x1)+(x2-x1)/pitch*i;
    float tmpy = (y1)+(y2-y1)/pitch*i;
    point(tmpx, tmpy);
    i++;
  }
}

void keyPressed() {
  bg=!bg;
}