import gab.opencv.*;
import processing.video.*;
import ddf.minim.*;
import ddf.minim.analysis.*;

Minim minim;
AudioPlayer song;
BeatDetect beat;
FFT fftLin;
Capture cam;

volatile float red =66;
volatile float green = 66;
volatile float blue = 244;
volatile float period = 0;

color[] means = new color[12];
PImage before, after;
CameraThread t;

void setup() {
  size(1280, 960);
  String fileName = "song.mp3";
  minim = new Minim(this);
  song = minim.loadFile(fileName, 1024);
  song.play();
  fftLin = new FFT( song.bufferSize(), song.sampleRate() );
  beat = new BeatDetect();


  cam = new Capture(this, 1280, 960, "name=Logitech HD Webcam C270,size=1280x960,fps=30");
  
  t = new CameraThread(this, cam);
  t.start();
  
  frameRate(30);0);
}

void draw() {
  red =   89 * sin((period * PI) / 6) + 89 + 66;
  green =   89 * sin((period * PI) / 6 + (2 * PI) / 3) + 89 + 66;
  blue =   89 * sin((period * PI) / 6 + (4 * PI) / 3) + 89 + 66;
  period += song.left.get(5);
  if (period >= 600){
      period -= 600;
  }
    
  t.colorSet(color(red, blue, green), color(blue, green, red));
    
  
  
}