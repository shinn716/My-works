import controlP5.*;


ControlP5 cp5;
PVector p_oldPos;
float f_angle;

float f_movSpeed=0;
float f_threshold1=0;
float f_threshold2=0;
boolean b_clear = false;
float f_strokeW=1;

void setup(){
  size(512, 512);
  p_oldPos = new PVector(width/2, height/2);
  f_angle = random(TWO_PI);


  cp5 = new ControlP5(this);

  cp5.addSlider("f_movSpeed")
     .setRange(0,10)
     .setValue(0)
     .setPosition(30,40)
     .setSize(100,10);

  cp5.addSlider("f_threshold1")
    .setRange(0,1)
    .setValue(0)
    .setPosition(30,60)
    .setSize(100,10);

  cp5.addSlider("f_threshold2")
    .setRange(0,1)
    .setValue(0)
    .setPosition(30,80)
    .setSize(100,10);

  cp5.addSlider("f_strokeW")
    .setRange(0,20)
    .setValue(5)
    .setPosition(30,100)
    .setSize(100,10);

  cp5.addToggle("b_clear")
    .setPosition(30,120)
    .setSize(30,15)
    .setMode(Toggle.SWITCH);

  // cp5.end();

  smooth();
}

void draw(){

  if(b_clear){
      background(180);
  }

  PVector newPos = new PVector(p_oldPos.x+f_movSpeed*cos(f_angle),
                               p_oldPos.y+f_movSpeed*sin(f_angle) );

  strokeWeight(f_strokeW);
  stroke(150*sin(radians(frameCount)), 80, 80);
  line(p_oldPos.x, p_oldPos.y, newPos.x, newPos.y);
  p_oldPos = newPos.copy();
  f_angle+=random(-f_threshold1, f_threshold2);

  if(p_oldPos.x>width){
    p_oldPos.x=0;
  }else if(p_oldPos.y>height){
    p_oldPos.y=0;
  }else if(p_oldPos.x<0){
    p_oldPos.x=width;
  }else if(p_oldPos.y<0){
    p_oldPos.y=height;
  }

}
