int cols,rows,w,h;
int scl = 20;
float terrain[][];
float flying = 0;
PImage img;

void setup() {
  size(600,600,P3D);
  w = 3000;
  h = 3000;
  cols = w/scl;
  rows = h/scl;
  terrain = new float[cols][rows];
  img = loadImage("daynight.png");
}

void draw() {
  
  flying -= 0.1;
  
  float yoff = flying;
  for (int i = 0; i < rows; i++){
    float xoff = 0;
    for (int j = 0; j < cols; j++){
      terrain[j][i] = map(noise(xoff,yoff), 0, 1, -150, 150);
      xoff+=0.1;
    }
    yoff+=0.1;
  }
  //background(img);
  image(img, width/2, height/2, yoff, yoff);
  stroke(0,0,0,50);
  
  translate(width/2, height/2+300); //translate the entire shape to 0,0 based on the canvas
  rotateX(PI/3); //rotate on the x-axis
  translate(-w/2, -h/2); //translate the entire shape to -300,-300 based on the shape
  
  for(int i = 0; i < rows-1; i++){
    beginShape(TRIANGLE_STRIP); //Begin creating the entire "terrain" by generating a triangle strip
    for(int j = 0; j < cols; j++){
      vertex(j*scl, i*scl, terrain[j][i]); //One point for every scl pixels. 
      vertex(j*scl, (i+1)*scl, terrain[j][i+1]);//One point for every scl pixels, and draw one more vertex on the next row.
      if (terrain[j][i] < 0){ fill(127, 101, 42);} //If the terrain is low, fill it brown.
      else {fill(255, 255, 255);} //If the terrain is high, fill it white.
    }
    endShape();
  }
}