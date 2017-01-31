import processing.video.*;

Capture cam;
int cellSize=16;
int rows, cols;

void setup() {
  size(640, 480);
  rows = width/cellSize;
  cols = height/cellSize;
  String[] cameras = Capture.list();
  if (cameras.length == 0) {
    println("There are no cameras available for capture.");
    exit();
  } else {
    println("Available cameras:");
    for (int i = 0; i < cameras.length; i++) {
      println(cameras[i]);
    }
    cam = new Capture(this, cameras[0]);
    cam.start();     
  } 
  noStroke();     
}

void draw() {
  if (cam.available() == true) {
    cam.read();
  }
  //image(cam, 0, 0);
  cam.loadPixels();
  for(int j=0; j<cols; j++){
  	for(int i=0; i<rows; i++){
  		int x = i*cellSize + cellSize/2;
  		int y = j*cellSize + cellSize/2;
  		int loc = x+y*width;
  		color c = cam.get(x,y);
  		fill(c);
  		ellipse(x, y, cellSize, cellSize);
  	}
  }
}