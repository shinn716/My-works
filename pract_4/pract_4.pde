int row=20;
int boxWidth=20;

void setup() {
	size(512, 512);
}

void draw() {
	background(200);
	for (int i=0; i<row; i++) {
			float x=i*width/(row-1);
			float y=height-200-abs(row/2-i)*2;

			float diffX = mouseX-x;
			float diffY = mouseY-y;	

			float s=dist(mouseX, mouseY, diffX, diffY);	
			float tmp=map(s,-500,500,0.5,1);


			diffX*=tmp;
			diffY*=tmp;	

			println("s: "+s);
			line(x+diffX, y+diffY, x, y);
			ellipse(x, y, boxWidth, boxWidth);
		}	
}