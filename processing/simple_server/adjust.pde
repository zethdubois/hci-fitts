float offset;

void adjustWin(int val) {
  if (!Grid) return;
  xS = xS + val;
  yS = yS + val;
  println("Window +",val);
}

void adjustBW(int val) {
  if (!Grid) return;
  bW = bW + val;
}

void setBW(int val) {
  if (!Grid) return;
  bW = val;
}

void adjustOff(float val) {
  if (!Grid) return;
  offset = offset + val;
  if (offset > 1) offset = 1;
  if (offset < .1) offset = .1;
}

void adjustPPI(int val) {
  if (!Grid) return;
  ppi = ppi + val;
}

void drawGrid() {
  int xT = findLong(1);
  int xT2 = xT;
  int xB; // long of butt B
  int xA = xC - xT; // long butt A

  stroke(255);
  fill(255);
  line(0, yC, xS, yC); //: horiz line
  pushMatrix();
  translate(-1*xT, 0);
  stroke(color(0, 255, 0)); 
  line(xC, 0, xC, yS); // dreaw thre butt A
  rectMode(CENTER);
  noFill();
  strokeWeight(4);
  rect(xC, yC, bW, bW);
  strokeWeight(1);
  stroke(255);
  
  //---------- measure lines
  while ((2*xT+xT2) > xT) {
    xT2 = xT2 - ppi;
    translate(ppi, 0);
    line(xC, 0, xC, yS);
  }
  popMatrix();
  pushMatrix();

  xB = xT + xC;
  translate(xT, 0);
  stroke(color(255, 0, 0)); // draw final line thru butt B
  line(xC, 0, xC, yS);
  strokeWeight(4);

  rect(xC, yC, bW, bW);

  //--- reset stuff
  strokeWeight(1);
  popMatrix();
  rectMode(CORNERS);
  fittsA = round((float(xB) - float(xA)) / float(ppi), 2);
  fittsW = round((float(bW) / float(ppi)), 2);
}
