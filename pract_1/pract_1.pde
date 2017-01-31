float x=0;
float y=0;
float xSpeed=0;
float ySpeed=0;
float p=0;
float areaPoint=100;
int add=20;
Boolean hit=false;

//controller
float boxWidth = 50;
float xMax=5;
float yMax=3;

void setup() {
	println("DEMO");
	size(700, 700);
	x=width/2;
	y=height/2;
	xSpeed=random(-xMax, xMax);	
	ySpeed=random(-yMax, yMax);
	rectMode(CENTER);
}

void draw() {
	p+=random(TWO_PI)*.01;

	stroke(0, 80);
	pushMatrix();
	translate(x, y);	
	rotate(cos(p));
	fill(255);
	rect(0, 0, boxWidth, boxWidth);
	popMatrix();

	x+=xSpeed;
	y+=ySpeed;

	if (x>=width-boxWidth/2 || x<=0+boxWidth/2) {	
		xSpeed*=-1;
		hit=false;
	} else if(y>=height-boxWidth/2 || y<=0+boxWidth/2){
		ySpeed*=-1;
		hit=false;
	} 

	println("var: "+dist(x, y, width/2, height/2));

	if( dist(x, y, width/2, height/2) <= (areaPoint/2) && hit==false ) {	
		println("hit");
		hit=true;
			areaPoint+=add;
			float pointWidth = areaPoint;
			fill(255,100,100, 200);
			ellipse(width/2, height/2, pointWidth, pointWidth);
	}
}