import gab.opencv.*;
import processing.video.*;

Capture cam;
OpenCV opencv;

color[] means = new color[12];
PImage before, after;

void setup() {
  size(1280, 960);
  
  String[] cameras = Capture.list();
  
  for(int i = 0; i < cameras.length; i++) {
    //println(i + ": " + cameras[i]);
  }
  
  cam = new Capture(this, 1280, 960, cameras[107]);
  cam.start();
  
  opencv = new OpenCV(this, cam);
  before = cam.copy();
  after = cam.copy();
  frameRate(30);
}

void draw() {
  //clear();
  if(cam.available()) {
    before = after.copy();
    cam.read();
  }
  
  image(cam, 0, 0);
  filter(POSTERIZE, 8);
  after = get();
  
  //drawKmeans(cam);
  drawPosterize(after.copy(), before, color(244,66,66), color(66,66,244));
  //kmeans(cam,1);
  
}