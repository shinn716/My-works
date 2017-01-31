import java.util.Calendar;

float f1=8;
float f2=3;
float delta=130;
float t=0;
float v=200;

int totallyPoint=1000;
PVector[] movPoint;

void setup() {
	size(512, 512);
	movPoint = new PVector[totallyPoint];	
}

void draw() {
	background(0);

	for(int i=0; i<totallyPoint; i++){
		float px = width/2+ v*sin(f1*t );
		float py = width/2+ v*sin(f2*t + delta);
		movPoint[i] = new PVector(px, py);
		t+=.01;
	}
	
	for(int i=0; i<totallyPoint; i++){
		beginShape();
		stroke(255);
		strokeWeight(1.5);
		vertex(movPoint[i].x, movPoint[i].y);
		endShape();			
	}
}

void keyPressed() {
  if (key == CODED) {
    if (keyCode == UP) {
		delta+=10;
 		println("UP " + delta);  	
    } else if (keyCode == DOWN) {
  		delta-=10;
  		println("DOWN "+ delta);
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