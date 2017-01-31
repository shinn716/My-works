float boxWidth=20;
int row=12;
int col=12;
color[] c = {color(255,100,100), color(100,255,100), color(100,100,255)};
color[][] t = new color[row][col];

void setup() {
	size(512, 512);
	smooth();
	rectMode(CENTER);

	for (int j=0;j<col;j++) {
		for (int i=0;i<row;i++) {
			int p=(int)random(0, 3);	
			t[i][j]=c[p];			
		}
	}
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
	
			fill(t[i][j]);
			rect(0, 0, boxWidth, boxWidth);	

			popMatrix();			
		}
	}
}
float qx=0,qy=0;