float offset; //<>// //<>//
float a_fittsA;
float b_fittsA;
float lfMod = 1.5f;
float fittsTP;


void adjustWin(int val) {
  if (!Setup) return;
  xS = xS + val;
  yS = yS + val;
  //println("Window +", val);
  println("broken, what did it do, anyway?");
}

void adjustBW(int val) {  
  if (!Setup) return;
  println(ts_bWp_arr[setTrial]);
  ts_bWp_arr[setTrial] += val;
  println(ts_bWp_arr[setTrial]);
  
}

//void setBW(int val) {
//  if (!Setup) return;
//  bW = val;
//}

void adjustAmp(float val) {
  if (!Setup) return;
  offset = offset + val;
  if (offset > 1) offset = 1;
  if (offset < .1) offset = .1;
}

void esAdjust(boolean Init, int i) {
  //: at this time, is only called from -->loadArgs()
  //: INIT <-- is not needed unless called from another proc later
  
  // >> i is 0-index for arrays (0 to es_trialCnt
  // >> init loads values from file

  if (Init) {
    ts_bWp_arr[i] = int(cnfgs.get("button_width_"+(i+1)));
    ts_off_arr[i] = float(cnfgs.get("offset_"+(i+1)));
  }
  ts_bAp_arr[i] = fittsA(i,"pixels");
  ts_ID_arr[i] = fittsID(i);
}

void adjustPPI(int val) {
  if (!Setup) return;
  ppi = ppi + val;
}

void drawGrid() {
  if (setTrial == -1) return;
  //println("settrial",setTrial);
  int xT = findLong(DUAL, 1, setTrial); //! this can break with the spacebar >> fix it
  int xT2 = xT;
  int xB; // long of butt B
  int xA = xC - xT; // long butt A
  int adj = boolToInt(DUAL); //(iMode+1) % 2; // to break into the while loop to draw lines for DUAL mode
  String S;
  int wS;
  //** draw credit card
  if (!DUAL) Calibrate = false;
  if (Calibrate) {
    //credit cards are 3.37 inches and 2.125 inches
    fill(255);
    textAlign(CENTER);
    textFont(iFont);
    fill(YELLOW);

    S = "Configuration for two screens\nrequires INCH unit measure calibration.";
    //wS = int(textWidth(S));
    text(S, xC, gutter*2);

    S = "Use number row [-] and [+] to change PPI\n[C] to close";
    text(S, xC, yS - gutter-lf*2);

    S = "or use\n\n< -- CREDIT CARD -- >";
    text(S, xC, yC - lf*2);


    rectMode(CENTER);
    strokeWeight(2);

    noFill();
    rect(xC, yC, int(ppi*3.37), int(ppi*2.125));
    textFont(nFont);
    strokeWeight(1);
  }

  stroke(255);
  line(0, yC, xS, yC); //: horiz line
  pushMatrix();
  translate(-1*xT, 0);
  stroke(color(0, 255, 0)); 
  line(xC, 0, xC, yS); // draw butt A meridian
  rectMode(CENTER);
  noFill();
  strokeWeight(4);
  if (!Calibrate) rect(xC, yC, ts_bWp_arr[setTrial], ts_bWp_arr[setTrial]); //: [ where button will be
  strokeWeight(1);
  stroke(255);
  //---------- measure lines
  if (Calibrate) {

    int i = xT2; // tricky business to run this while loop
    while ((2*xT+i)+adj > xT) {
      xT2 = xT2 - ppi;
      if (adj > 0) i = xT2*-1; 
      else i = xT2;
      if (i > xS / 2) break;
      translate(ppi, 0);
      line(xC, 0, xC, yS);
    }
  }

  popMatrix();
  pushMatrix();

  xB = xT + xC;
  translate(xT, 0);

  if (!DUAL) {
    stroke(color(255, 0, 0)); // draw final line thru butt B
    line(xC, 0, xC, yS);
    strokeWeight(4);
    rect(xC, yC, ts_bWp_arr[setTrial], ts_bWp_arr[setTrial]);
  }

  //--- reset stuff
  strokeWeight(1);
  popMatrix();
  rectMode(CORNERS);
  //replace with whichTrial arrays
  //if (DUAL) { 
  //  a_fittsA = round(float(xS/2) / float(ppi), 2);
  //} else {
  //  fittsA = round((float(xB) - float(xA)) / float(ppi), 2);
  //}
  //fittsW = round((float(bW) / float(ppi)), 2);

  fill(0);
}
