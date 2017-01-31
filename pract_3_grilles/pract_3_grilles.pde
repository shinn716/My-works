import java.util.Calendar;

float boxWidth=50;
float scaleV=0.005;		//0.01 0.002 0.005
float currentScale=1;
float threshold=1.2;
float px, py;
color c1,c2,c3,c4;

void setup() {
	size(512, 512);
	rectMode(CENTER);
	smooth();
	px=width/2;
	py=height/2;

	c1=color(random(0, 255));
	c2=color(random(0, 255));
	c3=color(random(0, 255));
	c4=color(random(0, 255));
	background(0);
}

void draw() {
	noStroke();
	translate(px, py);
	rotate(radians(frameCount));
	currentScale+=scaleV;

	if(currentScale>threshold){
		scaleV*=-1;
	}
	if(currentScale<-threshold){
		scaleV*=-1;
	}

	scale(currentScale);
	fill(c1, 20);				
	if(frameCount%50==0) {c1+=10;}
	rect(-width/2, -height/2, boxWidth, boxWidth,5);

	fill(c2, 20);			
	if(frameCount%50==0) {c2+=10;}	
	rect(width/2, -height/2, boxWidth, boxWidth,5);

	fill(c3, 20);				
	if(frameCount%50==0) {c3+=10;}	
	rect(-width/2, height/2, boxWidth, boxWidth,5);	

	fill(c4, 20);				
	if(frameCount%50==0) {c4+=10;}	
	rect(width/2, height/2, boxWidth, boxWidth,5);		
}

void keyPressed(){
	println("save");
	if (key=='s' || key=='S') saveFrame("output/"+timestamp()+"_##.png");
}

String timestamp() {
  Calendar now = Calendar.getInstance();
  return String.format("%1$ty%1$tm%1$td_%1$tH%1$tM%1$tS", now);
}