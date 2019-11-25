let showSec = true, updateTime = true;
let h,m,s;
let midX, midY, d, r;
let bg, fg;
const sizeFactor = .055;

function setup() {
  createCanvas(windowWidth, windowHeight);

  h = hour();
  m = minute();
  s = second();

  midX = width/2;
  midY = height/2;

  d = min(width, height) * 0.8;
  r = d * 0.5;

  fg = 255;
  bg = 0;
}

function draw() {
  background(bg);

  h = hour();
  m = minute();
  s = second();

  noFill();
  stroke(fg);

  ellipse(midX, midY, d, d);
  line(midX, midY-r, midX, midY+r);

  let ha = map(h % 12 + m / 60.0, 0, 12, 0, TWO_PI) - HALF_PI;
  let ma = map(m + s / 60.0, 0, 60, 0, TWO_PI) - HALF_PI;
  let sa = map(s, 0, 60, 0, TWO_PI) - HALF_PI;

  strokeWeight(2);
  line(midX, midY, cos(sa) * r + midX, sin(sa) * r + midY);

  strokeWeight(min(width, height) * sizeFactor);
  line(midX, midY, cos(ma) * r + midX, sin(ma) * r + midY);
  line(midX, midY, cos(ha) * r + midX, sin(ha) * r + midY);

}
