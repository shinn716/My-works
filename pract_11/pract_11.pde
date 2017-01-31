int num=10;
PVector[] target= new PVector[num];
PFont myFont;

PVector ball_position;
PVector ball_velocity=new PVector(0,0);

PVector targetPos=new PVector(0,0);
int currentTarget=0;

void setup() {
	size(512, 512);
	background(0);
	noStroke();

	myFont = createFont("calibri", 24);
	textFont(myFont);
	textAlign(CENTER, CENTER);	

	for(int i=0; i<num; i++){
		target[i]=new PVector(random(0,width), random(0,height));
		println(i + "\t" + target[i].x + " " + target[i].y);
	}
	ball_position = new PVector(width/2, height/2);
	targetPos=target[currentTarget].copy();
}


void draw() {
	background(0);
	
	PVector distance = PVector.sub(targetPos,ball_position);
	distance.mult(0.05);
	ball_position.add(distance);
				
	fill(255,80,80, 50);
	ellipse(ball_position.x, ball_position.y, 10, 10);

	if(PVector.dist(ball_position,targetPos)<5){		
		if(currentTarget>num-2){
			currentTarget=0;	
			targetPos=target[currentTarget].copy();	
		}else{
			currentTarget++;
			targetPos=target[currentTarget].copy();	
		}
	}
	//----display text
	for(int i=0; i<num; i++){
		fill(255, 80);
		ellipse(target[i].x, target[i].y, 10, 10);
		fill(255);
		text(i+1, target[i].x, target[i].y);		
	}

}