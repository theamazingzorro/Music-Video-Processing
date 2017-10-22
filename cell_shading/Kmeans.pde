void drawKmeans(PImage img) {
  kmeans(img, 1);
  
  opencv.loadImage(img);
  
  
  opencv.gray();
  opencv.adaptiveThreshold(475, 0);
  ArrayList<Contour> contours = opencv.findContours();
  
  
  noFill();
  stroke(0);
  strokeWeight(4);
  
  for (Contour contour : contours) {
    contour.draw();
  }
  
}


void kmeans(PImage img, int maxReps) {
  int r = 0, g = 0, b = 0;
  //color[] means = new color[8];
  color[] oldPixels;
  int[] sumR, counter, sumG, sumB;
  int[] closest;

  sumR = new int[means.length];
  counter = new int[means.length];
  sumG = new int[means.length];
  sumB = new int[means.length];

  image(img,0,0);
  loadPixels();
  
  oldPixels = pixels;
  boolean firstZero = true;
  for(int i = 0; i < means.length; i++) {
    if(means[i] == color(0)) {
      if(firstZero) {
        firstZero = false; 
      } else {
        means[i] = pixels[(int)random(0, pixels.length)];
      }
    }
  }
  
  closest = new int[pixels.length];
    
  for(int reps = 0; reps < maxReps; reps++) {
    int distance[] = new int[means.length];
  
    for(int i = 0; i < pixels.length; i++) {
      for(int k = 0; k < means.length; k++) {
        r = (int) (red(oldPixels[i]) - red(means[k]));
        g = (int) (green(oldPixels[i]) - green(means[k]));
        b = (int) (blue(oldPixels[i]) - blue(means[k]));

        distance[k] = (int)(sq(r) + sq(b) + sq(g));
      }
    
      int min = min(distance);
      for(int l = 0; l < distance.length; l++)
        closest[i] = (distance[l] == min) ? l : closest[i];
      
      sumR[closest[i]] += r;
      counter[closest[i]] ++;
      sumG[closest[i]] += g;
      sumB[closest[i]] += b;
    }
  
    int red, green, blue;
    for(int c = 0; c < means.length; c++) {
      counter[c]++;
      red = sumR[c] / counter[c];
      blue = sumB[c] / counter[c];
      green = sumG[c] / counter[c];
    
      means[c] = color(red, green, blue);
    }
  }
    
  for(int location = 0; location < img.pixels.length; location++) {
    pixels[location] = means[closest[location]];
  } 
  
  updatePixels();

}