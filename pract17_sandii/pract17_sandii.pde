import java.util.Calendar;
PVector[] pos;
PVector[] speed;
PImage img;
PVector[] target;
PVector[] tar_speed;

int cellSize=4;
int rows, cols;
float count=0;
float number=0.5;

void setup(){
  size(512, 512,OPENGL);
  // colorMode(HSB, 100, 100, 100);
  rows=width/cellSize;
  cols=height/cellSize;

  pos=new PVector[rows*cols];
  speed=new PVector[rows*cols];
  target=new PVector[rows*cols];
  tar_speed=new PVector[rows*cols];

  img = loadImage("sun-01.jpg");
  pixelImag();
  smooth();
}

void draw(){
  background(0);
  // background(0,10,0);

  if(mousePressed){
    //println("CLICK");

    // if(count>100){
    //   number*=-1;
    // }else if(count<0){
    //   number*=-1;
    // }
    count+=number;

    for(int j=0;j<cols;j++){
      for(int i=0;i<rows;i++){

        if(dist(pos[i+j*rows].x, pos[i+j*rows].y, mouseX, mouseY)<count){

          float dx= pos[i+j*rows].x - mouseX;
          float dy= pos[i+j*rows].y - mouseY;
          float DRoation = atan2(dy,dx);
          // float WRotation = DRoation/TWO_PI*360;
          float WRotation = radians(DRoation/PI*180);

          pos[i+j*rows].x+= round( count/dist(pos[i+j*rows].x, pos[i+j*rows].y, mouseX, mouseY) * cos(WRotation) );
          pos[i+j*rows].y+= round( count/dist(pos[i+j*rows].x, pos[i+j*rows].y, mouseX, mouseY) * sin(WRotation) );

           }else{

             float dx = target[i+j*rows].x - pos[i+j*rows].x;
             float dy = target[i+j*rows].y - pos[i+j*rows].y;
             pos[i+j*rows].x+=dx*tar_speed[i+j*rows].x;
             pos[i+j*rows].y+=dy*tar_speed[i+j*rows].y;

           }


         }
       }

  } else {
    if(count<0){
      count=0;
    } else{
      count-=number*2;
    }

    for(int j=0;j<cols;j++){
      for(int i=0;i<rows;i++){
        float dx = target[i+j*rows].x - pos[i+j*rows].x;
  	  	float dy = target[i+j*rows].y - pos[i+j*rows].y;
  			pos[i+j*rows].x+=dx*tar_speed[i+j*rows].x;
  			pos[i+j*rows].y+=dy*tar_speed[i+j*rows].y;
      }
    }

  }


  for(int j=0;j<cols;j++){
    for(int i=0;i<rows;i++){
      int x = i*cellSize + cellSize/2;   // x position
      int y = j*cellSize + cellSize/2;   // y position
      int loc = x + y*width;             // Pixel array location
      color c = img.pixels[loc];         // Grab the color
      strokeWeight(5);
      // stroke(75,80,30);
      stroke(c);
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

        speed[i+j*rows]=new PVector(random(-3, 3), random(-3, 3));
        pos[i+j*rows]=new PVector(x,y);
        target[i+j*rows]=new PVector(x,y);
        tar_speed[i+j*rows] = new PVector(random(.01, .01), random(.01, .01));
      }
    }

}


void keyPressed(){
	if (key=='s' || key=='S') {
		println("save");
		saveFrame("output/"+timestamp()+"_##.png");
	}
}

String timestamp() {
  Calendar now = Calendar.getInstance();
  return String.format("%1$ty%1$tm%1$td_%1$tH%1$tM%1$tS", now);
}
