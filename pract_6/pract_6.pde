int number=80;
float[] speedX=new float[number];
float[] speedY=new float[number];
float ballWidth=10;
float[] px=new float[number];
float[] py=new float[number];

void setup() {
	size(512, 512);
	for(int i=0;i<number;i++){
		px[i]=width/2;
		py[i]=height/2;
		speedX[i]=random(-2, 2);
		speedY[i]=random(-4, 4);	
	}
}

void draw() {
	noStroke();
	fill(0,10);
	rect(0, 0, width, height);
	for(int i=0;i<number;i++){
		px[i]+=speedX[i];
		py[i]+=speedY[i];	
		fill(255, 100*cos(radians(frameCount*1.5)));
		ellipse(px[i], py[i], ballWidth, ballWidth);		

		if(px[i]>width||px[i]<0){
			speedX[i]*=-1;
		}
		if(py[i]>height||py[i]<0){
			speedY[i]*=-1;
		}
	}

	if(mousePressed){
		println("Pressed");
		for(int i=0;i<number;i++){
			px[i]=width/2;
			py[i]=height/2;
			speedX[i]=random(-2, 2);
			speedY[i]=random(-4, 4);	
		}
	}
}