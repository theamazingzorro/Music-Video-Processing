class CameraThread extends Thread {
  Capture camera;
  OpenCV opencv;
  
  color backGround = color(0), foreGround = color(0);
  
  public CameraThread(cell_shading parent, Capture c) {
    camera = c;
    cam.start();
  
    opencv = new OpenCV(parent, cam);
    before = cam.copy();
    after = cam.copy();
  }
  
  @Override
  public void run() {
    if(cam.available()) {
      before = after.copy();
      cam.read();
    }
  
    image(cam, 0, 0);
    filter(POSTERIZE, 8);
    after = get();
  
    drawPosterize(after.copy(), before);
  }
  
  void colorSet(color b, color f) {
    backGround = b;
    foreGround = f;
  }
  
  void drawPosterize(PImage img, PImage before) {
    
    opencv.loadImage(before);
    opencv.diff(img);
  
    opencv.threshold(18);
  
    PImage mask = opencv.getSnapshot();
  
    //image(mask, 0, 0);
    
    for(int w = 0; w < img.width; w++) 
    for(int h = 0; h < img.height; h++) {
      //println(red(mask.pixels[i]));
      if(mask.get(w,h) == color(0)) {
        img.set(w,h, backGround);
      } else {
        color c = img.get(w,h);
        c = color(red(c) * red(foreGround) / 255, green(c) * green(foreGround) / 255, blue(c) * blue(foreGround) / 255);
        img.set(w, h, c);
      }
    }
  
    image(img, 0, 0);
    filter(POSTERIZE, 8);
  
  }
}