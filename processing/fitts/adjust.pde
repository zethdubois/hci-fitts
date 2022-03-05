float offset; //<>//
float a_fittsA;
float b_fittsA;
float lfMod = 1.5f;
float fittsTP;


void adjustWin(int val) {
  if (!Grid) return;
  xS = xS + val;
  yS = yS + val;
  println("Window +", val);
}

void adjustBW(int val) {
  if (!Grid) return;
  bW = bW + val;
  bSelect = "X";
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
  int xT = findLong(Dual, 1);
  int xT2 = xT;
  int xB; // long of butt B
  int xA = xC - xT; // long butt A
  int adj = boolToInt(Dual); //(iMode+1) % 2; // to break into the while loop to draw lines for dual mode

  stroke(255);
  line(0, yC, xS, yC); //: horiz line
  pushMatrix();
  translate(-1*xT, 0);
  stroke(color(0, 255, 0)); 
  line(xC, 0, xC, yS); // draw butt A
  rectMode(CENTER);
  noFill();
  strokeWeight(4);
  rect(xC, yC, bW, bW); //: draw box where button will be
  strokeWeight(1);
  stroke(255);
  //---------- measure lines
  int i = xT2; // tricky business to run this while loop
  while ((2*xT+i)+adj > xT) {
    xT2 = xT2 - ppi;
    if (adj > 0) i = xT2*-1; 
    else i = xT2;
    if (i > xS / 2) break;
    translate(ppi, 0);
    line(xC, 0, xC, yS);
  }
  popMatrix();
  pushMatrix();

  xB = xT + xC;
  translate(xT, 0);
  if (!Dual) {
    stroke(color(255, 0, 0)); // draw final line thru butt B
    line(xC, 0, xC, yS);
    strokeWeight(4);

    rect(xC, yC, bW, bW);
  }

  //--- reset stuff
  strokeWeight(1);
  popMatrix();
  rectMode(CORNERS);
  if (Dual) { 
    a_fittsA = round(float(xS/2) / float(ppi), 2);
  } else {
    fittsA = round((float(xB) - float(xA)) / float(ppi), 2);

  }
  fittsW = round((float(bW) / float(ppi)), 2);

  fill(0);
}
