import java.util.Calendar;

int X_STEP = 5;
int Y_STEP = 5;
int X, Y;
Folds myfolds;
float count=0;
float number=0.5;

RandomWalk[] myRandomWalk;
int nParticles = 0;


void setup(){
  size(500, 500);
  colorMode(HSB);
  noFill();
  X = int(width / X_STEP) + 1;
  Y = int(height / Y_STEP) + 1;

  myfolds=new Folds(X,Y);

  myfolds.init();
  //smooth();

  myRandomWalk = new RandomWalk[nParticles];

  for(int i=0; i<nParticles; i++) {
    myRandomWalk[i] = new RandomWalk();
  }
}

void draw(){
  background(0);
  myfolds.update();

  for(int i=0; i<nParticles; i++) {
    //println(myRandomWalk.pos);
    myRandomWalk[i].update();
    myfolds.rule(myRandomWalk[i].pos, 20);
  }

 if(mousePressed){

   if(count>100) {
     count=100;
   }else{
    count+=number;
   }
   //println(count);
    PVector mouse = new PVector(mouseX, mouseY);
    myfolds.rule(mouse, count);
  }else{

    if(count<0) {
      count=0;
    }else{
      count-=number;
    }

    myfolds.back();
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

class Folds{
  PVector[][] points;
  PVector[][] orgPos;
  int stepX, stepY;
  float FORCE_RADIOUS = 100;
  float MAX_FORCE = 5.0;
  color col;

  float colorCount=0;
  float nowColor=0;
  Boolean changeColor=false;
  float tmpColor;

  Folds(int tmpX, int tmpY){
    stepX=tmpX;
    stepY=tmpY;
    points = new PVector[X][Y];
    orgPos = new PVector[X][Y];
  }
  void init(){
    for(int y = 0; y < stepY; y += 1){
      for(int x = 0; x < stepX; x += 1){
        points[x][y] = new PVector(x * X_STEP, y * Y_STEP);
        orgPos[x][y] = new PVector(x * X_STEP, y * Y_STEP);
      }
    }
    tmpColor=random(0,360);
    col = color(tmpColor, 100, 255);
    nowColor=tmpColor;
    println(tmpColor);
  }

  void update(){
    stroke(col);
    for(int y = 0; y < stepY; y += 1){
      beginShape();
      curveVertex(points[0][y].x, points[0][y].y);
      for(int x = 0; x < stepX; x += 1){
        curveVertex(points[x][y].x, points[x][y].y);
      }
      curveVertex(points[stepX - 1][y].x, points[stepX - 1][y].y);
      endShape();
    }

    colorCount++;
    if(colorCount%500==0){
      changeColor=true;
      tmpColor=random(0,360);
      println("change to : " + tmpColor);
    }

    if(changeColor==true){
      //changeColor=false;
      nowColor += (tmpColor - nowColor) * .01;
      col = color(nowColor, 100, 255);
    }
  }

  void rule(PVector tmp, float tmpCount){

    for(int y = 0; y < stepY; y += 1){
      for(int x = 0; x < stepX; x += 1){

        if(dist(points[x][y].x, points[x][y].y, tmp.x, tmp.y)<tmpCount){

          float d = PVector.dist(points[x][y], tmp);
          if(d < FORCE_RADIOUS){
            PVector force = PVector.sub(points[x][y], tmp);
            force.normalize();
            force.mult(map(d, 0, FORCE_RADIOUS, MAX_FORCE, 0));
            points[x][y].add(force);
          }


        }else{
          //ease
          float d = PVector.dist(orgPos[x][y], points[x][y]);
          PVector force = PVector.sub(orgPos[x][y], points[x][y]);
          force.mult(map(d, 0, FORCE_RADIOUS, .01, .05));
          points[x][y].add(force);

        }

      }
    }


  }
  void back(){

    //ease
    for(int y = 0; y < stepY; y += 1){
      for(int x = 0; x < stepX; x += 1){

        float d = PVector.dist(orgPos[x][y], points[x][y]);
        PVector force = PVector.sub(orgPos[x][y], points[x][y]);
        force.mult(map(d, 0, FORCE_RADIOUS, .01, .05));
        points[x][y].add(force);

      }
    }
  }

}

class RandomWalk{

  float xoff = 0.0;
  float posStepR = 2;
  public PVector pos;
  float angle;
  float dRange;
  float dAngle;
  color c;

  RandomWalk(){
    pos = new PVector(0, 0);
    angle  = random(TWO_PI);
    dRange = 0.01;
    dAngle = 0;
    c = color(random(255), random(255), random(255));

    pos.x=width/2;
    pos.y=height/2;
  }

  void update(){
    xoff = xoff + .01;
    float n = noise(xoff) * posStepR;

    float cor = dRange*atan(15*dAngle)/PI;
    float randNum = (random(2)-1)*dRange-cor;  //Random number from (-dRange, dRange)
    dAngle+=randNum;                       //We don't change the angle directly
    //but its differential - source of the smoothness!
    angle+=dAngle;                         //new angle is angle+dAngle
    pos.x+=n*cos(angle);            //just move on step
    pos.y+=n*sin(angle);
    fill(c,0);
    noStroke();
    //translate(width/2, height/2);
    ellipse(pos.x, pos.y, 20, 20);
  }
}
