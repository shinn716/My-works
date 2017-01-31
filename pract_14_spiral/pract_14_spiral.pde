import java.util.Calendar;
float r=10;
float b=0;

int count=0;
boolean flag=false;
color[] colorPanl = {#F05941, #BE3144, #872341, #2F1B41};
color colorDraw;
int colorCount=0;
float theta=0;

void setup() {
  size(512, 512);
  background(#2F1B41);
  colorDraw = colorPanl[colorCount];
}
 
void draw() {
  noFill();
  stroke(colorDraw, 60);
  translate(width/2, height/2);
  
  if(flag){
    b+=-(r/3);
    count--;
  }else{
    b+=(r/3);
    count++;
  }
  
  if(b>=width*2) {
    flag=true; 
  } else if(b<0) {
    flag=false; 
    theta+=90;
    colorCount++;
    colorDraw = colorPanl[colorCount%4];
  }

  float t = radians(count*5);
  ellipse(t*r*cos(t+radians(theta)), t*r*sin(t+radians(theta)), b, b);
}

void keyPressed(){
  println("save");
  if (key=='s' || key=='S') saveFrame("output/"+timestamp()+"_##.png");
}

String timestamp() {
  Calendar now = Calendar.getInstance();
  return String.format("%1$ty%1$tm%1$td_%1$tH%1$tM%1$tS", now);
}
