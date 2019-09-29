boolean showSec = false, updateTime = true, invert = false;
int h,m,s;
float midX, midY, d, r;
int bg, fg;

void setup() {
  size(800, 800);
  pixelDensity(displayDensity());
  
  h = hour();
  m = minute();
  s = second();
  
  midX = width/2;
  midY = height/2;
  
  d = width * 0.8;
  r = d * 0.5;
  
  bg = 255;
  fg = 0;
  
}

void draw() {
  background(bg);
  
  if (updateTime) {
    h = hour();
    m = minute();
    s = second();
  }
  
  noFill();
  stroke(fg);
  strokeWeight(width * .065);
  
  ellipse(midX, midY, d, d);
  line(midX, midY-r, midX, midY+r);
  
  
  float ha = map(h % 12 + ((float) m) / 60.0, 0, 12, 0, TWO_PI) - HALF_PI;
  float ma = map(m + ((float) s) / 60.0, 0, 60, 0, TWO_PI) - HALF_PI;
  float sa = map(s, 0, 60, 0, TWO_PI) - HALF_PI;
  
  if (showSec)
    line(midX, midY, cos(sa) * r + midX, sin(sa) * r + midY);
  
  line(midX, midY, cos(ma) * r + midX, sin(ma) * r + midY);
  line(midX, midY, cos(ha) * r + midX, sin(ha) * r + midY);
}

void keyPressed() {
  switch(key) {
    case 's':
    showSec = !showSec;
    break;
    case ' ':
    updateTime = !updateTime;
    break;
    case 'i':
    int tmp = bg;
    bg = fg;
    fg = tmp;
    break;
  }
}
