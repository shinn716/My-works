import java.util.Calendar;

float f1=8;
float f2=3;
float delta=PI/2;
float v=230;

int totallyPoint=1000;
PVector[] movPoint;

color[] c;
float rand1, rand2, rand3;
float px = 0.0;

float col=3;
float time=0;

PImage img;
int spacePressedCount=0;

void setup() {
	size(512, 512);
	movPoint = new PVector[totallyPoint];

  c = new color[totallyPoint];
  //coloriInit();
  img = loadImage("a-02.jpg"); 
  lissInit();
}

void draw() {
	background(0);
	noStroke();
  	for(int i=0; i<totallyPoint; i++){
  		px = width*i/totallyPoint;
  		fill(c[i]);
  		ellipse(px, 10, 5, 5);
  	}

 	lissDraw();
}

void keyPressed() {
  if (key == CODED) {
    if (keyCode == UP) {
      delta+=PI/2;
      println("UP " + delta);
      lissInit();
      lissDraw();
    } else if (keyCode == DOWN) {
      delta-=PI/2;
      println("DOWN "+ delta);      
      lissInit();
      lissDraw();
    } else if(keyCode == LEFT){
      f2++;
      println("LEFT " + f2);
      lissInit();
      lissDraw();      
    } else if(keyCode == RIGHT){
      f2--;
      println("RIGHT " + f2);
      lissInit();
      lissDraw();      
    }
  } else {
    println("SPACE & SAVE");
    saveFrame("output/"+timestamp()+"_##.png");
    spacePressedCount++;
    if(spacePressedCount%2==0){
      img = loadImage("a-02.jpg");
      lissInit();
    } else{
      img = loadImage("a-01.jpg");
      lissInit();
    }

    //coloriInit();
  }
}

void coloriInit(){
	rand1 = (int)random(20, 255);
  	rand2 = (int)random(20, 255);
  	rand3 = (int)random(20, 255);
  
   	for (int i=0; i<totallyPoint; i++) {
    	c[i]=color( round(rand1/2+10)+(rand1/2)*sin(radians(i/col)), round(rand2/2+10)+(rand2/2)*sin(radians(i/col)), round(rand3/2+10)+(rand3/2)*sin(radians(i/col)) );
  	}
}

void lissDraw(){
 	for (int i=0; i<totallyPoint; i++) {
   		//stroke(c[i], i*150/totallyPoint);
      stroke(c[i]);	
   		int tmp=i+1;
   		if(tmp>totallyPoint-1) tmp=0;
   		line(movPoint[i].x, movPoint[i].y, movPoint[tmp].x, movPoint[tmp].y);
 	}
}

void lissInit(){
	for (int i=0; i<totallyPoint; i++) {
		float px = width/2+ v*sin(f1*time );
    float py = width/2+ v*sin(f2*time + delta);
    movPoint[i] = new PVector(px, py);
    c[i] = getTransparentColor( img.get((int)px, (int)py), 64 );
    time+=i/2;
 	}
}

color getTransparentColor( color c, float a )
{
    int r = (c >> 16) & 0xff;
    int g = (c >> 8) & 0xff;
    int b = c & 0xff;
    
    return color(r, g, b, a);
}

String timestamp() {
  Calendar now = Calendar.getInstance();
  return String.format("%1$ty%1$tm%1$td_%1$tH%1$tM%1$tS", now);
}