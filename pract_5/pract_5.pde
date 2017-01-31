float boxWidth=20;
float row=12;
float col=12;

void setup() {
	size(512, 512);
	smooth();
	rectMode(CENTER);
}

void draw() {
	background(200);
	float tx=map(mouseX,0,width,0,100);
	float ty=map(mouseY,0,height,0,100);

	//println(tx+" "+ty);

	for (int j=0;j<col;j++) {
		for (int i=0;i<row;i++) {
			//println("i: "+i);
			pushMatrix();
			float x = i*width/(row-1);
			float y = j*height/(col-1);
			translate(x, y);
			rotate(radians(tx*i+ty*j+frameCount));

			fill(255,0,0);
			ellipse(0, 15, 5, 5);
			fill(255,255,255);
			rect(0, 0, boxWidth, boxWidth);	

			popMatrix();			
		}
	}
}
float qx=0,qy=0;