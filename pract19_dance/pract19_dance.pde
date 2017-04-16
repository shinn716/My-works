import java.util.Calendar;

float t=0;
Boolean drawLine=true;
float colorRandom;
int count=0;

float y=0;
int num=10;

void setup() {
  size(512, 512);
  colorMode(HSB, 100);
  background(0);
  smooth();

  colorRandom=random( 0, 80);
  // println("color: "+colorRandom);
}

void draw() {

  if(drawLine){
    noStroke();
    fill(0);
    rect(0, 0, width, height);
  }

  float w = map(mouseY, 0, height, 0, 8);
  strokeWeight(w);

  float d = map(mouseX, 0, width, 0, (float) (10*PI));
  t+=  Math.toRadians(d);

  translate(width/2, height/2);

    for (int i=0; i<num; i++) {
      float prec = i / (float)20;
      float sin = y+20*sin(prec*PI/2);
      stroke( sin, 100, 100);
      line(px1(t+i), py1(t+i), px2(t+i), py2(t+i));
    }

  count++;
  if(count%500==0){
    colorRandom=random( 0, 80);
    // println("color: "+colorRandom);
  }else{
    y += (colorRandom - y) * 0.05;
  }

  // if(count%2==0){
  //   saveFrame("output/"+timestamp()+"_##.png");
  // }
}

float px1(float t) {
  return (float) ( 140*Math.sin(t/10)  );
}

float py1(float t) {
  return (float) (140*Math.cos(t/10) );
}

float px2(float t) {
  return (float) (250*Math.sin(t/8/2) );
}

float py2(float t) {
  return (float) (250*Math.cos(t/16/2) );
}

void keyPressed() {

  if (key=='a') {
    drawLine=!drawLine;
  }
  if (keyCode==UP) {
    num++;
  }
  if (keyCode==DOWN) {
    num--;
    if(num<=0) num=1;
  }
  if (key=='s' || key=='S') {
    println("save");
    saveFrame("output/"+timestamp()+"_##.png");
  }
}

String timestamp() {
  Calendar now = Calendar.getInstance();
  return String.format("%1$ty%1$tm%1$td_%1$tH%1$tM%1$tS", now);
}
