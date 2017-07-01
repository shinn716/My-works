// This sketch shows how to use the FFT class to analyze a stream  
// of sound. Change the variable bands to get more or less 
// spectral bands to work with. Smooth_factor determines how
// much the signal will be smoothed on a scale form 0-1.

import processing.sound.*;

// Declare the processing sound variables 
SoundFile sample;
FFT fft;
AudioDevice device;

// Declare a scaling factor
int scale=10;

// Define how many FFT bands we want
int bands = 2048;

// declare a drawing variable for calculating rect width
float r_width;

// Create a smoothing vector
float[] sum = new float[bands];

// Create a smoothing factor
float smooth_factor = 0.5;

ShinnUtil shUtil = new ShinnUtil();

public void setup() {
  size(640, 360);
  background(255);

  // If the Buffersize is larger than the FFT Size, the FFT will fail
  // so we set Buffersize equal to bands
  device = new AudioDevice(this, 44000, bands);

  // Calculate the width of the rects depending on how many bands we have
  r_width = width/float(bands);

  //Load and play a soundfile and loop it. This has to be called 
  // before the FFT is created.
  sample = new SoundFile(this, "001.mp3");
  sample.loop();

  // Create and patch the FFT analyzer
  fft = new FFT(this, bands);
  fft.input(sample);
}      

public void draw() {
  // Set background color, noStroke and fill color
  background(125, 255, 125);
  fill(255, 0, 150);
  noStroke();

  fft.analyze();

  translate(width/2, height/2);
  for (int i = 0; i < bands; i++) {

    float[] temp = fft.spectrum;
    //shUtil.shiftToCenter(temp);
    sum[i] = lerp(temp[i], sum[i], smooth_factor);
    float r = map(i, 0, 1024, 0, TWO_PI*10 );


    pushMatrix();
    //float rot = map(i, 0, 1024, 0, TWO_PI);
    //rotate(rot);
    rect( i*r_width*cos(r), i*r_width*sin(r), r_width*2f, -sum[i]*height*scale );
    popMatrix();
  }
}