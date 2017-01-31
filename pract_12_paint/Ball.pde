class Ball{
	PVector position;
	PVector velocity;
	float ballWidth=20;

	float tmpx, tmpy;
	PVector target;

	Ball(float tx, float ty){
		position = new PVector(random(0, width), random(0, height));
		velocity = new PVector(0, 0);

		tmpx=tx;
		tmpy=ty;
	}

	void update(){
		target=new PVector(tmpx, tmpy);
		PVector dis = PVector.sub(target, position);
		dis = PVector.sub(target, position);
		dis.mult(0.0001);

		velocity.add(dis);
		velocity.mult(1);
		position.add(velocity);

		float reTar = PVector.dist(target, position);
		if(reTar<2){
			now=true;
		}
	}
	void display(){
		ellipse(position.x, position.y, ballWidth, ballWidth);

		if(ballWidth<=-20){
			ballWidth=20;
		}else{
			ballWidth-=.5;
		}
	}

	void updateTarget(float tx, float ty){
		tmpx=tx;
		tmpy=ty;
	}

	void drawTar(color tc){
		fill(tc,90);
	}
}