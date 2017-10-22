void drawPosterize(PImage img, PImage before, color background, color foreground) {
  
  opencv.loadImage(before);
  opencv.diff(img);

  opencv.threshold(18);

  PImage mask = opencv.getSnapshot();

  //image(mask, 0, 0);
  
  for(int w = 0; w < img.width; w++) 
  for(int h = 0; h < img.height; h++) {
    //println(red(mask.pixels[i]));
    if(mask.get(w,h) == color(0)) {
      img.set(w,h, background);
    } else {
      color c = img.get(w,h);
      c = color(red(c) * red(foreground) / 255, green(c) * green(foreground) / 255, blue(c) * blue(foreground) / 255);
      img.set(w, h, c);
    }
  }

  image(img, 0, 0);
  filter(POSTERIZE, 8);

}