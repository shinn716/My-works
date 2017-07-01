
int i_count;
boolean b_state=false;

int i_wrCount;
Wrinkles[] myWrinkles;

void setup() {

  size(1024, 768);

  i_count=360;

  i_wrCount=8;
  myWrinkles = new Wrinkles[i_wrCount];
  for (int i=0; i<i_wrCount; i++) {

    myWrinkles[i] = new Wrinkles(i_count, new PVector(width/2, height/2) );
    myWrinkles[i].init();
  }

  smooth();
}


void draw() {

  fill(#EFF7D3, 80);
  rect(0, 0, width, height);


  for (int i=0; i<i_wrCount; i++) {

    myWrinkles[i].update(b_state);
    myWrinkles[i].show();
  }
}


void mousePressed() {
  b_state = !b_state;
}




class Wrinkles {

  int i_allPoint;
  PVector objPos;

  float f_r, f_ro, f_dr;
  PVector[] p_tarPos;
  PVector[] p_tarPos2;
  PVector[] p_orgPos;
  float f_moveSpeed;
  float f_alpha;

  Wrinkles(int t_count, PVector t_pos) {

    i_allPoint = t_count;
    objPos = t_pos.copy();

    p_tarPos =  new PVector[i_allPoint];
    p_tarPos2 = new PVector[i_allPoint];
    p_orgPos =  new PVector[i_allPoint];

    f_ro = random(100, 120);
    f_moveSpeed=random(3, 20);
    f_dr = random(-f_ro, f_ro);
    f_alpha = random(20, 60);
    //println(f_moveSpeed);
  }

  void init() {

    for (int i=0; i<i_allPoint; i++ ) {

      //float px = width/2  + f_ro*2*cos(radians(i));
      //float py = height/2 + f_ro*2*sin(radians(i));     

      //p_tarPos[i] = new PVector(px, py);
      p_orgPos[i] = new PVector(objPos.x, objPos.y);
      p_tarPos2[i] = new PVector(objPos.x, objPos.y);
    }
  }

  void update(boolean t_state) {

    for (int theta = 0; theta < 360; theta+=(360/i_allPoint) ) {

      if (t_state) {

        //---- ellipse
        int loc = theta/(360/i_allPoint);
        float n = map(frameCount*0.005f, 0, TWO_PI, -f_ro, f_ro);
        n = map(noise(n, theta), 0, 1, -f_dr/35f, f_dr/35f);
        f_r = f_ro + n;
        
        float px = width/2  + f_r * 3.2f * cos(radians(loc));
        float py = height/2 + f_r * 3.2f * sin(radians(loc));     
        p_tarPos[loc] = new PVector(px, py);

        //int loc = theta/(360/i_allPoint);
        p_orgPos[loc].x = lerp(p_orgPos[loc].x, p_tarPos[loc].x + f_moveSpeed*cos(radians(frameCount)), 0.05f);
        p_orgPos[loc].y = lerp(p_orgPos[loc].y, p_tarPos[loc].y + f_moveSpeed*sin(radians(frameCount)), 0.05f);
        
      } else {

        //---- wrink
        float n = map(frameCount*0.0005f, 0, TWO_PI, -f_ro, f_ro);
        n = map(noise(n, theta), 0, 1, -f_dr/2, f_dr/2);
        f_r = f_ro + n;

        float nx = objPos.x + f_moveSpeed*cos(radians(frameCount)) + f_r * cos(radians(theta) ) ;
        float ny = objPos.y + f_moveSpeed*sin(radians(frameCount)) + f_r * sin(radians(theta) ) ;

        int loc = theta/(360/i_allPoint);
        p_tarPos2[loc] = new PVector(nx, ny);


        p_orgPos[loc].x = lerp(p_orgPos[loc].x, p_tarPos2[loc].x, 0.05f);
        p_orgPos[loc].y = lerp(p_orgPos[loc].y, p_tarPos2[loc].y, 0.05f);
        
      }
    }
  }

  void show() {

    noFill();
    stroke(#535A3B, f_alpha);

    //beginShape();
    for (int theta = 0; theta < 360; theta+=(360/i_allPoint) ) {

      int loc = theta/(360/i_allPoint);
      int tmp = loc+1;
      if (tmp>360-2) tmp=0;
      line(p_orgPos[loc].x, p_orgPos[loc].y, p_orgPos[tmp].x, p_orgPos[tmp].y);
      //ellipse(p_orgPos[loc].x, p_orgPos[loc].y, 10, 10);
      //vertex(nx, ny);
    }
    //endShape(CLOSE);
  }
}