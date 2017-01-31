PVector position;
PVector velocity = new PVector(0,0);
PVector acceleration = new PVector(0,0);

void setup() {
	smooth();
	//noStroke();
	size(512, 512);
	position = new PVector(width/2, height/2);	
}

void draw(){
	background(200);
	//PVector mouse = new PVector(width/2+100*cos(radians(frameCount*3)), height/2+100*sin(radians(frameCount*2))); 
	//ellipse(width/2+100*cos(radians(frameCount*2)), height/2, 30, 30);

	//----跟滑鼠
	PVector mouse = new PVector(mouseX, mouseY); 	
	acceleration = PVector.sub(mouse,position);
	acceleration.mult(0.005);

	velocity.add(acceleration);
	velocity.mult(0.98);
	position.add(velocity);
	ellipse(position.x, position.y, 20, 20);

	//----反彈
	if(position.y>height+10 || position.y<0-10){
		velocity.y*=-0.9;
	}
	if(position.x>width+10 || position.x<0-10) {
		velocity.x*=-0.9;
	}
}