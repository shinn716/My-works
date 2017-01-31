float boxWidth=50;
float scaleV=0.1;
float currentScale=1;
float threshold=1.2;
float px=0;
float py=0;
float xSpeed=1;
float ySpeed=1;

void setup() {
	size(512, 512);
	rectMode(CENTER);
	smooth();
	xSpeed=random(1, 2);
	ySpeed=random(1, 2);
	px=width/2;
	py=height/2;
}

void draw() {

	translate(px, py);
	rotate(radians(frameCount));
	px+=xSpeed;
	py+=ySpeed;	
	
	currentScale+=scaleV;

	if(currentScale>threshold){
		scaleV*=-1;
	}
	if(currentScale<-threshold){
		scaleV*=-1;
	}

	scale(currentScale);
	rect(0, 0, boxWidth, boxWidth,5);

	if(px>width || px<0){
		xSpeed*=-1;
	}
	if(py<=0 || py>height){
		ySpeed*=-1;
	}
}