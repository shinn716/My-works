import java.util.Calendar;
import geomerative.*;

int number;

PVector[] velocity;
PVector[] position;
PVector[] target;
PVector[] acceleration;

RFont font;
String textTyped = "My nane is Tung-Chen.";
RPoint[] pnts;
float ballWidth=7;				//200:7
float disttmp;
int fontSize=100;

void setup() {
	size(1024, 512);

	// allways initialize the library in setup
	RG.init(this);
  	font = new RFont("FreeSans.ttf", fontSize, RFont.LEFT);
  	RCommand.setSegmentLength (8);
  	RCommand.setSegmentator(RCommand.UNIFORMLENGTH);

  	RGroup grp;
    grp = font.toGroup(textTyped);
    grp = grp.toPolygonGroup();
    pnts = grp.getPoints();
    disttmp=grp.getWidth();
    println("dots number: " + pnts.length + "\tsentence width: " + grp.getWidth());
    
    //-----文字大小 座標 校正
    float tmp = width/(disttmp+20);
    println("tmp: "+tmp);
	int tmp2 = (int)round(fontSize*tmp);
    println("tmp2: "+tmp2);
    grp = font.toGroup(textTyped);
    font = new RFont("FreeSans.ttf", tmp2, RFont.LEFT);
    grp = font.toGroup(textTyped);
    grp = grp.toPolygonGroup();
    pnts = grp.getPoints();
    disttmp=grp.getWidth();

    number = pnts.length;
    position = new PVector[number];
    velocity = new PVector[number];
    target = new PVector[number];
    acceleration = new PVector[number];

    ballWidth = tmp2/20;

	for(int i=0;i<number;i++){
		position[i] = new PVector(width/2, height/2);
		velocity[i] = new PVector(random(.01, .05), random(.01, .05));
		target[i] = new PVector(pnts[i].x, pnts[i].y);	
	}
	smooth();
}

void draw() {
	noStroke();
	fill(0,10);
	rect(0, 0, width, height);
	//showSentence();

	for(int i=0;i<number;i++){
		pushMatrix();
    	translate((width-disttmp)/2-10, height/2);
    	acceleration[i] = PVector.sub(target[i], position[i]);
    	position[i].x += acceleration[i].x*velocity[i].x;
    	position[i].y += acceleration[i].y*velocity[i].y;
		fill(255);
		ellipse(position[i].x, position[i].y, ballWidth, ballWidth);	
		popMatrix();
	}

	//saveFrame("output/"+timestamp()+"_##.jpg");
}

void showSentence(){
    for (int i = 0; i < pnts.length; i++ ) {
    	pushMatrix();
    	translate(70, height/2);
      	//println(i + "\t" + pnts[i].x + "\t" + pnts[i].y);
      	fill(255);
      	ellipse(pnts[i].x, pnts[i].y, ballWidth, ballWidth);
      	popMatrix();
    }
}

void mousePressed(){
	println("Pressed");
	for(int i=0;i<number;i++){
		position[i] = new PVector(width/2, height/2);
		velocity[i] = new PVector(random(.005, .05), random(.005, .05));
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