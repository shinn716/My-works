import java.util.Calendar;

float f1=9;
float f2=6;
float delta=0;
float t=0;

color c;
float rand1, rand2, rand3;


void setup() {
  size(512, 512);
  background(0);	
  rand1 = (int)random(20, 255);
  rand2 = (int)random(20, 255);
  rand3 = (int)random(20, 255);
}

void draw() {
  noStroke();
  fill(0, 1);
  rect(0, 0, width, height);

  float px = width/2+ 200*sin(f1*t );
  float py = width/2+ 200*sin(f2*t + delta);
  //println("px: "+px);
  t+=.01;

  c=color( (rand1/2)+10+rand1*sin(radians(frameCount)), (rand2/2)+10+rand2*sin(radians(frameCount)), (rand3/2)+10+rand3*sin(radians(frameCount)) );
  strokeWeight(2);
  stroke(c);
  beginShape();
  vertex(px, py);	
  endShape();
}

void keyPressed() {
  if (key == CODED) {
    if (keyCode == UP) {
      delta+=10;
      println("UP " + delta);
      rand1 = (int)random(20, 255);
      rand2 = (int)random(20, 255);
      rand3 = (int)random(20, 255);
    } else if (keyCode == DOWN) {
      delta-=10;
      println("DOWN "+ delta);
      rand1 = (int)random(20, 255);
      rand2 = (int)random(20, 255);
      rand3 = (int)random(20, 255);
    }
  }
  
  if (key=='s' || key=='S') {
    println("save");
    saveFrame("output/"+timestamp()+"_##.png");
    background(0);
  }
}

String timestamp() {
  Calendar now = Calendar.getInstance();
  return String.format("%1$ty%1$tm%1$td_%1$tH%1$tM%1$tS", now);
}