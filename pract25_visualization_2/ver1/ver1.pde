import processing.sound.*;

SoundFile sample;
FFT fft;
AudioDevice device;
int scale=5;
int bands;
float r_width;
float[] sum;
float smooth_factor = 0.01f;


int rows, cols;
int scl = 20;
int w = 640*2;
int h = 600;
float[][] terrain;
float flying=0;

ShinnUtil shUtil;

float f_scalar=0f;
float wheel=0;

void setup() {
  size(1024, 512, P3D);
  rows = w/scl;
  cols = h/scl;

  //smooth();
  bands = rows;
  sum = new float[bands];
  println("bands: " + bands);

  terrain = new float[rows][cols];

  //----audio
  device = new AudioDevice(this, 44000, bands);
  r_width = width/float(bands);
  sample = new SoundFile(this, "001.mp3");
  sample.loop();
  fft = new FFT(this, bands);
  fft.input(sample);

  shUtil = new ShinnUtil();
}

void draw() {
  
  f_scalar = lerp(f_scalar, wheel, .25f);
  float moveX = map(mouseX, 0, width, -width, width);
  println(moveX);
  camera(moveX, height/2.0, f_scalar, width/2.0, height/2.0, 0, 0, -1, 0);
  
  background(0);
  stroke(255);
  noFill();
  translate(width/2, height/2);
  //float value = map(mouseY, 0, height,-PI, PI);


  audioInit();
  //terrUpdate();
  terrShow();
}

void terrUpdate() {

  flying-=0.01f;
  float yoff = flying;
  for (int y=0; y<cols; y++) { 
    float xoff = 0;
    for (int x=0; x<rows; x++) {
      terrain[x][y] = map(noise(xoff, yoff), 0, 1, -100f, 100f);
      xoff+=0.1f;
    }
    yoff-=0.1f;
  }
}

void terrShow() {

  rotateX(PI/3);
  translate(-w/2, -h/2);

  for (int y=0; y<cols-1; y++) {  
    beginShape(TRIANGLE_STRIP);
    for (int x=0; x<rows; x++) { 
      vertex(x*scl, y*scl, terrain[x][y]);
      vertex( (x)*scl, (y+1)*scl, terrain[x][y+1]);
    }
    endShape();
  }
}


void audioInit() {

  fft.analyze();
  for (int i = bands/2; i < bands; i++) {
    float[] temp = fft.spectrum;
    sum[i] = lerp(temp[i-bands/2], sum[i], smooth_factor);
  }

  for (int i = 0; i < bands/2; i++) {
    float[] temp = fft.spectrum;
    sum[i] = lerp(temp[bands/2-i], sum[i], smooth_factor);
  }

  //for (int i = 0; i < bands; i++) {

  //  float[] temp = fft.spectrum;
  //  //if(test)
  //  //  shUtil.mirrorArray(temp);

  //  sum[i] = lerp(temp[i], sum[i], smooth_factor);
  //  //println(i + " " + sum[i]);
  //}


  //for (int y=0; y<cols; y++) { 
  for (int x=0; x<rows; x++) {
    terrain[x][count] = -sum[x]*100*scale;
  }
  //}

  if (frameCount%10==0) {

    if (count>cols-2) {
      count=0;
    } else {
      count++;
    }
  }
}

int count=0;

boolean test=false;
void mouseClicked() {
  test=!test;
}


void mouseWheel(MouseEvent event) {
  float e = event.getCount();
  // println(e);

  if (e==1) {
    wheel-=20;
    //forward
  } else if (e==-1) {
    wheel+=20;
    //backword
  }
}