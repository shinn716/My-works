import java.util.Calendar;

int cellSize=8;
int cols, rows;
int leftStart, upStart, rightStart, downStart;

float movX=0, movY=0, _movX=0, _movY=0;
int count=0;

PImage img;

void setup() {
	size(512, 512,P3D);
	rows = width/cellSize;
	cols = height/cellSize;
	_movX=width;
	_movY=width;
	noStroke();

	leftStart=round(random(0, cols-1));
	upStart=round(random(0, rows-1));
	rightStart=round(random(0, cols-1));
	downStart=round(random(0, rows-1));

	img = loadImage("a-03.jpg"); 
	background(0);
}

void draw() {

	if(frameCount%2==0){
		movX+=cellSize;
		movY+=cellSize;
		_movX-=cellSize;
		_movY-=cellSize;		
	}

	if(movX>width){
		movX=0;
		leftStart=round(random(0, cols-1));
	}

	if(movY>height){
		movY=0;
		upStart=round(random(0, cols-1));
	}
	if(_movX<0){
		_movX=width;
		rightStart=round(random(0, cols-1));
	}

	if(_movY<0){
		_movY=height;
		downStart=round(random(0, cols-1));
	}

	//----3D ver.
	float x = movX-cellSize/2;
	float y = leftStart*cellSize + cellSize/2;
	color c = img.get(round(x), round(y));
	float z = map(brightness(c), -5, x, 0, 100);

	fill(c,90);
	pushMatrix();
	translate(x, y, z); 
	ellipse(0, 0, cellSize, cellSize);
   	popMatrix();

	float x2 = _movX-cellSize/2;
	float y2 = rightStart*cellSize+cellSize/2;
	color c2 = img.get(round(x2), round(y2));		
	float z2 = map(brightness(c2), -5, x2, 0,100);

	fill(c2,90);
	pushMatrix();
	translate(x2, y2, z2); 
	ellipse(0, 0, cellSize, cellSize);
   	popMatrix();

	float x3 = upStart*cellSize+cellSize/2;
	float y3 = movY-cellSize/2;	
   	color c3 = img.get(round(x3), round(y3));		
	float z3 = map(brightness(c3), -5, x3, 0,100);

	fill(c3,90);
	pushMatrix();
	translate(x3, y3, z3); 
	ellipse(0, 0, cellSize, cellSize);
   	popMatrix();

	float x4 = downStart*cellSize+cellSize/2;
	float y4 = _movY-cellSize/2;	
	color c4 = img.get(round(x4), round(y4));		
	float z4 = map(brightness(c4), -5, x4, 0,100);

	fill(c4,90);
	pushMatrix();
	translate(x4, y4, z4); 
	ellipse(0, 0, cellSize, cellSize);
   	popMatrix();

	//----2D ver.
	// color c = img.get(round(movX-cellSize/2), round(leftStart*cellSize + cellSize/2));
	// fill(c,80);
	// ellipse(movX-cellSize/2, leftStart*cellSize + cellSize/2, cellSize, cellSize);

	// color c2 = img.get(round(upStart*cellSize + cellSize/2), round(movY-cellSize/2));
	// fill(c2,80);
	// ellipse(upStart*cellSize + cellSize/2, movY-cellSize/2, cellSize, cellSize);


	// color c3 = img.get(round(_movX-cellSize/2), round(rightStart*cellSize+cellSize/2));
	// fill(c3,80);
	// ellipse(_movX-cellSize/2, rightStart*cellSize+cellSize/2, cellSize, cellSize);

	// color c4 = img.get(round(downStart*cellSize+cellSize/2), round(_movY-cellSize/2) );
	// fill(c4,80);
	// ellipse(downStart*cellSize+cellSize/2, _movY-cellSize/2, cellSize, cellSize);
}

void keyPressed() {
  if (key=='s' || key=='S') {
  	println("save");
    saveFrame("output/"+timestamp()+"_##.png");
  }
}

String timestamp() {
  Calendar now = Calendar.getInstance();
  return String.format("%1$ty%1$tm%1$td_%1$tH%1$tM%1$tS", now);
}