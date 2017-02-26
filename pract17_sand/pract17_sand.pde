PVector[] pos;
PVector[] speed;
PImage img;


int cellSize=2;
int rows, cols;

void setup(){
  size(512, 512,OPENGL);
  rows=width/cellSize;
  cols=height/cellSize;

  pos=new PVector[rows*cols];
  speed=new PVector[rows*cols];

  img = loadImage("004-01.jpg");
  pixelImag();
  smooth();
}

void draw(){
  background(0);
  for(int j=0;j<cols;j++){
    for(int i=0;i<rows;i++){

      int x = i*cellSize + cellSize/2;   // x position
      int y = j*cellSize + cellSize/2;   // y position
      int loc = x + y*width;             // Pixel array location
      color c = img.pixels[loc];         // Grab the color

      if(brightness(img.pixels[loc])<150){
        pos[i+j*rows].add(speed[i+j*rows]);
      }

      strokeWeight(1);
      stroke(255);
      point(pos[i+j*rows].x,pos[i+j*rows].y);

    }
  }

}


void pixelImag(){
  for(int j=0; j<cols; j++){
      for(int i=0; i<rows; i++){
        int x = i*cellSize + cellSize/2;   // x position
        int y = j*cellSize + cellSize/2;   // y position
        int loc = x + y*width;             // Pixel array location
        color c = img.pixels[loc];         // Grab the color

        speed[i+j*rows]=new PVector(0, random(1, 3));
        pos[i+j*rows]=new PVector(x,y);
      }
    }

}
