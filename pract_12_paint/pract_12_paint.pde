import java.util.Calendar;
int number=200;		//80
Ball[] myBall = new Ball[number];

PVector rPs;
boolean now=false; 

color[] tarC = new color[number];
color[] c = {#48466D, #3D84A8, #46CDCF, #ABEDD8};

void setup() {
	size(512, 512);
	background(#ABEDD8,3);	
	rPs = new PVector(random(0, width), random(0, height));		//target position

	for(int i=0; i<myBall.length; i++){
  		myBall[i] = new Ball(rPs.x, rPs.y);
  		int p=(int)random(0, 4);
  		tarC[i] = c[p];
  	}

	smooth();
	noStroke();
}

void draw() {

	for(int i=0; i<myBall.length; i++){					//partcitle motion
		myBall[i].drawTar(tarC[i]);
		myBall[i].update();
		myBall[i].display();
	}

	if(now){											//renew target position		
		float rx=random(0, width), ry=random(0, height);
		println(rx + " " + ry);
		for(int i=0; i<myBall.length; i++){
  			myBall[i].updateTarget(rx, ry);
    		int p=(int)random(0, 3);
  			tarC[i] = c[p];			
  		}
  		now=false;
	}
}

void mousePressed(){
	for(int i=0; i<myBall.length; i++){
  		myBall[i].updateTarget(mouseX, mouseY);
    	int p=(int)random(0, 3);
  		tarC[i] = c[p];			
  	}
}

void keyPressed(){
	println("save");
	if (key=='s' || key=='S') saveFrame("output/"+timestamp()+"_##.png");
}

String timestamp() {
  Calendar now = Calendar.getInstance();
  return String.format("%1$ty%1$tm%1$td_%1$tH%1$tM%1$tS", now);
}