import java.util.Calendar;
float r=10;
float b=0;

int count=0;
boolean flag=false;
color[] colorPanl = {#F05941, #BE3144, #872341, #2F1B41};
color colorDraw;
int colorCount=0;
float theta=0;

int parr1 = 0;
int parr2 = 0;

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
    b+=-(r/4);
    count--;
  }else{
    b+=(r/4);
    count++;
  }
  
  if(b>=width*1.5) {
    flag=true; 
  } else if(b<0) {
    flag=false; 
    theta+=90;
    colorCount++;
    colorDraw = colorPanl[colorCount%4];
  }

  float t = radians(count*5);
  ellipse(t*r*cos(t)*pow(sin(t), parr1), t*r*sin(t)*pow(cos(t), parr2), b, b);      //
  //ellipse(t*r*cos(t)*pow(sin(t), parr1), t*r*sin(t)*pow(cos(t), parr2), 1, 1);    //測試軌跡
}


String timestamp() {
  Calendar now = Calendar.getInstance();
  return String.format("%1$ty%1$tm%1$td_%1$tH%1$tM%1$tS", now);
}

void keyPressed() {
  if (key=='s' || key=='S') saveFrame("output/"+timestamp()+"_##.png");
  if (keyCode == UP) {
    background(#2F1B41);
    parr1++; 
    //graph_1();
    println("UP " + "Parr1: " + parr1 + " Parr2: " + parr2);
  }
  if (keyCode == DOWN) {
    background(#2F1B41);
    parr1--; 
    //graph_1();
    println("DOWN " + "Parr1: " + parr1 + " Parr2: " + parr2);
  }
  if (keyCode == LEFT) {
    background(#2F1B41);
    parr2++; 
   // graph_1();
    println("LEFT " + "Parr1: " + parr1 + " Parr2: " + parr2);
  }
  if (keyCode == RIGHT) {
    println("RIGHT " + "Parr1: " + parr1 + " Parr2: " + parr2);
    background(#2F1B41);
    parr2--; 
    //graph_1();
    println("RIGHT " + "Parr1: " + parr1 + " Parr2: " + parr2);
  }
}
