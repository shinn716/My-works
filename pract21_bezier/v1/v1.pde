//  inspired from Abe Pazos
//  https://www.youtube.com/watch?v=MJWdbY0TISg&list=PL632BB8C3F7E776BA&index=76

int i_allCounts=80;
PVector[] pointTmp;
PVector[] movetoPos;
Boolean[] pickup;
float f_W = 30;
int i_pickUp=0;
//float[] f_movetoMpx, f_movetoMpy;
Boolean[] once;

void setup() {
  size(512, 512);

  pointTmp = new PVector[i_allCounts];
  pickup = new Boolean[i_allCounts];
  once = new Boolean[i_allCounts];
  //f_movetoMpx = new float[i_allCounts];
  //f_movetoMpy = new float[i_allCounts];
  movetoPos = new PVector[i_allCounts];

  for(int i=0; i<pointTmp.length; i++){
     pointTmp[i] = new PVector(width/2, height/2);
     pickup[i] = false;
     once[i] = false;
     movetoPos[i] = new PVector(width/2, height/2);
  }

  noCursor();
}

void draw() {

  background(0);
  noFill();
  stroke(255);

  float t = frameCount/1000f;
  ellipse(width/2, height/2, 5, 5);


  for (int i=0; i<i_allCounts; i++) {

    if (mouseX>pointTmp[i].x-f_W/2 && mouseX<pointTmp[i].x+f_W/2 &&
        mouseY>pointTmp[i].y-f_W/2 && mouseY<pointTmp[i].y+f_W/2) {

      movetoPos[i].x = lerp(movetoPos[i].x, mouseX, 0.3f);
      movetoPos[i].y = lerp(movetoPos[i].y, mouseY, 0.3f);

      pointTmp[i] = new PVector(movetoPos[i].x, movetoPos[i].y);
      pickup[i] = true;

    } else {

      pointTmp[i] = new PVector(noise(4, i, t)*width, noise(5, i, t)*height);
      pickup[i] = false;

    }

    bezier(width/2, height/2,
      width/2, noise(1, i, t)*height,
      noise(2, i, t)*width, noise(3, i, t)*height,
      pointTmp[i].x, pointTmp[i].y );
    ellipse(pointTmp[i].x, pointTmp[i].y, 5, 5);
  }



  //----Pick up
  for(int i=0; i<pickup.length; i++){
    if(pickup[i] && once[i]==false){
      once[i]=true;
      i_pickUp++;

    }

    if(pickup[i]==false && once[i]==true){
      once[i]=false;
      i_pickUp--;

    }

  }

  float tmpW = f_W/2;
  rect(mouseX-tmpW/2, mouseY-tmpW/2, tmpW, tmpW);
  showFPS();
}

void showFPS() {
  fill(255);
  textSize(18);
  text("FPS  " + Math.round(frameRate), width-70, 18);
  text("PICK " + i_pickUp, width-70, 36);
}
