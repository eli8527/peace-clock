let showSec = true, updateTime = true;
let h,m,s;
let midX, midY, d, r;
let bg, fg;
const sizeFactor = .055;

function setup() {
  createCanvas(windowWidth, windowHeight);
  speed = 1;

  now = new Date();

  q = new URLSearchParams(location.search);
  if (q.has('time')) {
    t = q.get('time').split(':');
    if (t.length === 3 && t[0].length == 2 && t[1].length == 2 && t[2].length == 2) {
      now.setHours(parseInt(t[0]));
      now.setMinutes(parseInt(t[1]));
      now.setSeconds(parseInt(t[2]));
    }
  }

  if (q.has('speed')) {
    s = q.get('speed');
    speed = parseInt(s);
  }

  h = now.getHours();
  m = now.getMinutes();
  s = now.getSeconds();

  setInterval(function() {
    now = new Date(now.getTime() + 1000);
    h = now.getHours();
    m = now.getMinutes();
    s = now.getSeconds();
  }, 1000 / speed);

  midX = width/2;
  midY = height/2;

  d = min(width, height) * 0.8;
  r = d * 0.5;

  fg = 255;
  bg = 0;
}

function draw() {
  background(bg);

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

// function updateTime() {
//   now = new Date(now.getTime() + 1000);
//   h = now.getHours();
//   m = now.getMinutes();
//   s = now.getSeconds();
// }