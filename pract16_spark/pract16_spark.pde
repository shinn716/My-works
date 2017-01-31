import java.util.Calendar;

int count;
PVector[] array1;
PVector[] speed1;

float connection=50;
color[] colorTri;
int[] alpha;
PImage img;

//----Circle
PVector[] target;
boolean fun1=false;
PVector[] speed2;
int clickCount=1;

void setup() {
	size(512, 512, OPENGL);
	count = 90;
	array1 = new PVector[count];
	speed1 = new PVector[count];
	colorTri = new color[count];
	alpha = new int[count];

	//----Circle
	target = new PVector[count];
	float angle=360/count;
	float force=width/2-100;
	speed2 = new PVector[count];

	//----init
	for(int i=0; i<count; i++){
		array1[i] = new PVector(random(width), random(height));
		speed1[i] = new PVector(random(-1, 1), random(-1, 1));
		alpha[i] = round(random(20,60));
		speed2[i] = new PVector(random(.01, .1), random(.01, .1));
		target[i] = new PVector(width/2+force*cos(radians(angle*i)), height/2+force*sin(radians(angle*i)));
	}

	img = loadImage("a-02.jpg"); 
}

void draw() {
	background(0);

	//----init all points
	for(int i=0; i<count; i++){
		strokeWeight(10);
		colorTri[i] = img.get(round(array1[i].x), round(array1[i].y));
		beginShape(POINTS);

		if(fun1){
			float dx = target[i].x - array1[i].x;
	  		float dy = target[i].y - array1[i].y;
			array1[i].x+=dx*speed2[i].x;
			array1[i].y+=dy*speed2[i].y;	
		}
		else{
			array1[i].add(speed1[i]);
		}
		stroke(colorTri[i], alpha[i]);
		vertex(array1[i].x, array1[i].y);
		endShape();
	}
	noStroke();

	//----points function.
	for(int i=0; i<count; i++){
		if(array1[i].x<0 || array1[i].x>width){
			speed1[i].x*=-1;
		}
		if(array1[i].y<0 || array1[i].y>height){
			speed1[i].y*=-1;
		}
	}

	//----connection self and anothers.
	for(int k=0; k<count; k++){
		for(int j=0; j<count; j++){
			for(int i=0; i<count; i++){
				if( dist(array1[i].x, array1[i].y, array1[j].x, array1[j].y)<connection 
				 && dist(array1[j].x, array1[j].y, array1[k].x, array1[k].y)<connection 
				 //&& dist(array1[k].x, array1[k].y, array1[i].x, array1[i].y)<connection 
				 ){
					fill(colorTri[i], alpha[i]);
					beginShape();
					vertex(array1[i].x, array1[i].y);
					vertex(array1[j].x, array1[j].y);
					vertex(array1[k].x, array1[k].y);
					endShape();
				}
			}
		}
	}
}

void mousePressed(){
	clickCount++;
	println("CLICK: " + clickCount);

	if(clickCount%2==0){
		float angle=360/count;
		float force = width/2-10-random(0, 120);
		for(int i=0; i<count; i++){
			target[i] = new PVector(width/2+force*cos(radians(angle*i)), height/2+force*sin(radians(angle*i)));
		}
		connection=50;
		fun1=true;
	} else if(clickCount%3==0||clickCount%11==0){
		int randTmp=round(random(3, 45));		//special 44
		println("randTmp: " + randTmp);
		for(int i=0; i<count; i++){
			float angle=360/count;
			target[i] = new PVector(width/2+angle*i*cos(radians(angle*i*randTmp)), height/2+angle*i*sin(radians(angle*i*randTmp)));
		}
		connection=60;
		fun1=true;
	} else if(clickCount%7==0){
		for(int i=0; i<count; i++){
			float angle=360/count;
			target[i] = new PVector(width/2+angle*i*cos(radians(angle*i*44)), height/2+angle*i*sin(radians(angle*i*44)));
		}
		connection=60;
		fun1=true;
	}

	else{
		connection=50;		
		fun1=false;
	}
}

void keyPressed(){
	if (key=='s' || key=='S') {
		println("save");
		saveFrame("output/"+timestamp()+"_##.png");
	}
}

String timestamp() {
  Calendar now = Calendar.getInstance();
  return String.format("%1$ty%1$tm%1$td_%1$tH%1$tM%1$tS", now);
}