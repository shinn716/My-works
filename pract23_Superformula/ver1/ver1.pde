import controlP5.*;

float t2;
ControlP5 cp5;
int m1, m2;
float n, n2, n3, a, b;
boolean auto=false;
float shapeSize;


void setup() {
  size(512, 512);
  background(0);
  noFill();
  smooth();

  cp5 = new ControlP5(this);


  Group g1 = cp5.addGroup("g1")
                .setPosition(30,50)
                .setWidth(160)
                .setBackgroundHeight(180)
                .setBackgroundColor(color(255,50))
                ;

  cp5.addSlider("m1")
    .setRange(0, 100)
    .setValue(4)
    .setPosition(10, 10)
    .setSize(100, 10)
    .setGroup(g1);

  //  cp5.addSlider("m2")
  //    .setRange(0, 20)
  //    .setValue(6)
  //    .setPosition(30, 60)
  //    .setSize(100, 10);

  cp5.addSlider("n")
    .setRange(1, 10)
    .setValue(3)
    .setPosition(10, 30)
    .setSize(100, 10)
    .setGroup(g1);

  cp5.addToggle("auto")
    .setPosition(10, 50)
    .setSize(20, 10)
    .setMode(Toggle.SWITCH)
    .setGroup(g1);  

  cp5.addSlider("n2")
    .setRange(1, 20)
    .setValue(3)
    .setPosition(10, 80)
    .setSize(100, 10)
    .setGroup(g1);

  cp5.addSlider("n3")
    .setRange(1, 20)
    .setValue(3)
    .setPosition(10, 100)
    .setSize(100, 10)
    .setGroup(g1);

  cp5.addSlider("a")
    .setRange(0, 5)
    .setValue(1)
    .setPosition(10, 120)
    .setSize(100, 10)
    .setGroup(g1);

  cp5.addSlider("b")
    .setRange(0, 5)
    .setValue(1)
    .setPosition(10, 140)
    .setSize(100, 10)
    .setGroup(g1);

  cp5.addSlider("shapeSize")
    .setRange(1, 200)
    .setValue(100)
    .setPosition(10, 160)
    .setSize(100, 10)
    .setGroup(g1);
    
    
}

void draw() {

  background(0);
  //translate(width/2, height/2);
  beginShape();
  stroke(255);

  for (float t=0; t<2*Math.PI; t+=2*Math.PI/360) {

    float r = (float) rad(t, a, b, m1, m2, t2, n2, n3);

    float x = width/2  + (float) (r*Math.cos(t)*shapeSize);
    float y = height/2 + (float) (r*Math.sin(t)*shapeSize);

    vertex(x, y);
  }

  endShape();

  if (auto) {
    println("T");
    t2 = -n+n*sin(radians(frameCount));
  } else {
    println("F");
    t2=n;
  }

  showText();
}

void showText() {
  textSize(14);
  stroke(255);
  text("Superformula (m1=m2) Ref. wiki/Superformula", 30, 30);
}

float rad(float theta, double a, double b, float m1, float m2, double n1, double n2, double n3) {
  return (float) Math.pow( (Math.pow( Math.abs(Math.cos(m1*theta/4.0)/a), n2) + Math.pow( Math.abs(Math.sin(m1*theta/4.0)/b), n3)), -1/n1);
}