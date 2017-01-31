int count=100;
float f=4;
float[] px = new float[count];
float[] py1 = new float[count];
float[] py2 = new float[count];
float y1=0,y2=0;
float r=8;

void setup() {
	size(512, 512);
	noStroke();
	smooth();

	y1=80+40*sin(radians(frameCount*2));
	y2=(height-80)+40*cos(radians(frameCount*2));	
	for(int i=0;i<count;i++){
		px[i]=width*i/count;
		py1[i]=80;
		py2[i]=(height-80);	
	}
}

void draw() {
	fill(0, 5);
	rect(0, 0, width, height);
	//background(0);
	for(int i=count-1;i>=0;i--){
		if(i==0){
			py1[i]=y1;
			py2[i]=y2;			
		}else{
			py1[i]=py1[i-1];
			py2[i]=py2[i-1];	
			fill(255);	
			//fill(255,10);					
			ellipse(px[i],py1[i], r, r);
			ellipse(px[i],py2[i], r, r);
			ellipse(py1[i],px[i], r, r);
			ellipse(py2[i],px[i], r, r);			
		}
	}
	y1=80+40*sin(radians(frameCount*2));
	y2=(height-80)+40*cos(radians(frameCount*2));
	//saveFrame("output/pic-###.jpg");
}