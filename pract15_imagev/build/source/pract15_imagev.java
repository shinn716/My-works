import processing.core.*; 
import processing.data.*; 
import processing.event.*; 
import processing.opengl.*; 

import java.util.HashMap; 
import java.util.ArrayList; 
import java.io.File; 
import java.io.BufferedReader; 
import java.io.PrintWriter; 
import java.io.InputStream; 
import java.io.OutputStream; 
import java.io.IOException; 

public class pract15_imagev extends PApplet {

PImage img;
int cols=0, rows=0;
int cellSize=4;


PVector[] position;
PVector[] velocity;
PVector[] gravity;

int[] corAll;
boolean click = false;

PVector[] target;


float x;
float y;
float easing = 0.05f;

int count=0;

public void setup() {
	
	img=loadImage("data/003.jpg");

	cols=width/cellSize;
	rows=height/cellSize;

	velocity=new PVector[cols*rows];
	position=new PVector[cols*rows];
	gravity=new PVector[cols*rows];
	corAll=new int[cols*rows];
	target=new PVector[cols*rows];

	noStroke();
	pixelImag();
}

public void draw() {

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
					velocity[i+j*rows].y*=-0.5f;
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
					position[i+j*rows].y+=dy*gravity[i+j*rows].y*.05f;

					fill(corAll[i+j*rows]);
 					ellipse(position[i+j*rows].x, position[i+j*rows].y, cellSize, cellSize);
      		}
    	}
	}
}

public void mousePressed(){
	println("Click");
	count++;
	if(count%2==0){
		click=false;
	}else{
		click=true;
	}
}


public void pixelImag(){
  for(int j=0; j<cols; j++){
      for(int i=0; i<rows; i++){
        int x = i*cellSize + cellSize/2;   // x position
        int y = j*cellSize + cellSize/2;   // y position
        int loc = x + y*width;             // Pixel array location
        int c = img.pixels[loc];         // Grab the color

				velocity[i+j*rows]=new PVector(0,0);
				position[i+j*rows]=new PVector(x,y);
				corAll[i+j*rows]=c;
				gravity[i+j*rows]=new PVector(0, random(.2f, 1.5f));
				target[i+j*rows]=new PVector(x,y);
    	}
		}
}
  public void settings() { 	size(512, 512); }
  static public void main(String[] passedArgs) {
    String[] appletArgs = new String[] { "pract15_imagev" };
    if (passedArgs != null) {
      PApplet.main(concat(appletArgs, passedArgs));
    } else {
      PApplet.main(appletArgs);
    }
  }
}
