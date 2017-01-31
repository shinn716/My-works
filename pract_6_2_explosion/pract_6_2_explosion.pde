import java.util.Calendar;

int number=360;
float[] speedX=new float[number];
float[] speedY=new float[number];
float ballWidth=10;
float[] px=new float[number];
float[] py=new float[number];

float[] targetX = new float[number];
float[] targetY = new float[number];

void setup() {
	size(512, 512);
	float angle=360/number;
	float force=width/2-ballWidth;	
	for(int i=0;i<number;i++){
		px[i]=width/2;
		py[i]=height/2;
		speedX[i]=random(.005, .05);
		speedY[i]=random(.005, .05);	

		targetX[i]=width/2+force*cos(radians(angle*i));
		targetY[i]=height/2+force*sin(radians(angle*i));
		println(targetX[i]+"\t"+targetY[i]);		
	}
}

void draw() {
	noStroke();
	//background(0);
	fill(0,10);
	rect(0, 0, width, height);

	for(int i=0;i<number;i++){
	  	float dx = targetX[i] - px[i];
	  	float dy = targetY[i] - py[i];

		px[i]+=dx*speedX[i];
		py[i]+=dy*speedY[i];	
		fill(255, 60*cos(radians(frameCount*1.5)));
		// fill(255);
		ellipse(px[i], py[i], ballWidth, ballWidth);		
	}

	if(mousePressed){
		println("Pressed");
		for(int i=0;i<number;i++){
			px[i]=width/2;
			py[i]=height/2;
			speedX[i]=random(.005, .05);
			speedY[i]=random(.005, .05);	
		}
	}
	//saveFrame("output/pic-###.gif");
}

void keyPressed(){
	println("save");
	if (key=='s' || key=='S') saveFrame("output/"+timestamp()+"_##.png");
}

String timestamp() {
  Calendar now = Calendar.getInstance();
  return String.format("%1$ty%1$tm%1$td_%1$tH%1$tM%1$tS", now);
}