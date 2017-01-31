PImage img;
int cellSize=8;
int cols, rows;

void setup() {
  size(512, 512);
  img = loadImage("data/001.jpg");
  cols = height/cellSize;
  rows = width/ cellSize;
  noStroke();
}

void draw() {
  noLoop();
  pixelImag();
}

void pixelImag(){
  for(int j=0; j<cols; j++){
      for(int i=0; i<rows; i++){
        int x = i*cellSize + cellSize/2;   // x position
        int y = j*cellSize + cellSize/2;   // y position  
        int loc = x + y*width;             // Pixel array location
        color c = img.pixels[loc];         // Grab the color
        fill(c);
        ellipse(x, y, cellSize, cellSize);
      }
    }
}