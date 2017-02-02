PImage img;
int cols=0, rows=0;
int cellSize=4;


PVector[] position;
PVector[] velocity;
PVector[] gravity;

color[] corAll;
boolean click = false;

PVector[] target;


float x;
float y;
float easing = 0.05;

int count=0;

void setup() {
	size(512, 512);
	img=loadImage("data/003.jpg");

	cols=width/cellSize;
	rows=height/cellSize;

	velocity=new PVector[cols*rows];
	position=new PVector[cols*rows];
	gravity=new PVector[cols*rows];
	corAll=new color[cols*rows];
	target=new PVector[cols*rows];

	noStroke();
	pixelImag();
}

void draw() {

	//image(img, 0, 0, width, height);
	background(0);

	if(click){
 		for(int j=0; j<cols; j++){
 			for(int i=0; i<rows; i++){
				velocity[i+j*rows].add(gravity[i+j*rows] );
				position[i+j*rows].add(velocity[i+j*rows] );

 				fill(corAll[i+j*rows]);
 				ellipse(position[i+j*rows].x, position[i+j*rows].y, cellSize, cellSize);

 				if(position[i+j*rows].y+cellSize/2>height){
					velocity[i+j*rows].y*=-0.5;
					position[i+j*rows].y=height-cellSize/2;
				}
				// if(position[i+j*rows].x+cellSize/2<0 || position[i+j*rows].x+cellSize/2>width) {
				// 	position[i+j*rows].x*=-1;
				// }
 			}
    	}
	} else {
 		for(int j=0; j<cols; j++){
      		for(int i=0; i<rows; i++){

 					//float dx = target[i+j*rows].x - position[i+j*rows].x;
	  			float dy = target[i+j*rows].y - position[i+j*rows].y;
					//position[i+j*rows].x+=dx*gravity[i+j*rows].x*.5;
					position[i+j*rows].y+=dy*gravity[i+j*rows].y*.05;

					fill(corAll[i+j*rows]);
 					ellipse(position[i+j*rows].x, position[i+j*rows].y, cellSize, cellSize);
      		}
    	}
	}
}

void mousePressed(){
	println("Click");
	count++;
	if(count%2==0){
		click=false;
	}else{
		click=true;
	}
}


void pixelImag(){
  for(int j=0; j<cols; j++){
      for(int i=0; i<rows; i++){
        int x = i*cellSize + cellSize/2;   // x position
        int y = j*cellSize + cellSize/2;   // y position
        int loc = x + y*width;             // Pixel array location
        color c = img.pixels[loc];         // Grab the color

				velocity[i+j*rows]=new PVector(0,0);
				position[i+j*rows]=new PVector(x,y);
				corAll[i+j*rows]=c;
				gravity[i+j*rows]=new PVector(0, random(.2, 1.5));
				target[i+j*rows]=new PVector(x,y);
    	}
		}
}
