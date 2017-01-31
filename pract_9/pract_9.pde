PVector position;
PVector velocity;
PVector gravity = new PVector(0,2);

void setup() {
	size(512, 512);
	velocity = new PVector(0,0);
	position = new PVector(width/2, height/2);	
}

void draw(){
	background(200);
	velocity.add(gravity);
	position.add(velocity);
	ellipse(position.x, position.y, 40, 40);

	if(position.y+20+10>height){
		velocity.y*=-0.9;
		position.y=height-20-10;
	}
}
void mousePressed(){
	position.set(mouseX, mouseY);
}