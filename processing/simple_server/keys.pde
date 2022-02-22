int samples = 0;
int trials = 0;
Boolean Trial = false;
Boolean Grid = false;
float fittsA, fittsW; //: amplitude / width
int bW; //: button width pixels
import java.math.*;
color startColor = color(0, 255, 0);
color stopColor = color(255, 0, 0);

void keyPressed() {
  println("key", key);

  switch(key) {
  case 't': 
    startTrial();
    break;
  case ' ': 
    println("Setups");  
    setups();
    break;
  case '-': 
    println("decrease space");  
    adjustPPI(-1);
    break;
  case '=': 
    println("increase space");  
    adjustPPI(1);
    break;
  case '_': 
    println("decrease space");  
    adjustPPI(-10);
    break;
  case '+': 
    println("increase space");  
    adjustPPI(10);
    break;
  case '[': 
    println("decrease button size");  
    adjustBW(-1);
    break;
  case ']': 
    println("increase button size");  
    adjustBW(1);
    break;
  case '{': 
    println("decrease button size");  
    adjustBW(-10);
    break;
  case '}': 
    println("increase button size");  
    adjustBW(10);
    break;     
  default:
    break;
  }
}


void updateButtons() {
  int test ;
  try {
    test = cp5.getController("bangOn").getId();
  } 
  catch(Exception e) {
    test = 0;
  }
  if (test != 0) {
    cp5.getController("bangOn").remove();
    cp5.getController("bangOff").remove();
  } else {
    println(">>>>>>>>>>>>>>>>>>>>>>>>>>>>>>> no buttons");
    int xT = findLong(1);
    cp5.addBang("bangOn")
      .setPosition(xC-bW/2-xT, yC-bW/2)
      .setSize(bW, bW)
      .setColorForeground(startColor)
      .setLabel("start")
      ;
    cp5.addBang("bangOff")
      .setPosition(xC-bW/2+xT, yC-bW/2)
      .setSize(bW, bW)
      .setColorForeground(stopColor)
      .setLabel("stop")
      ;
  }
}


void adjustBW(int val) {
  if (!Grid) return;
  bW = bW + val;
  //updateButtons();
}


void adjustPPI(int val) {
  if (!Grid) return;
  ppi = ppi + val;
}


public static float round(float d, int decimalPlace) {
  BigDecimal bd = new BigDecimal(Float.toString(d));
  bd = bd.setScale(decimalPlace, BigDecimal.ROUND_HALF_UP);
  return bd.floatValue();
}

void drawGrid() {
  print("Drawgrid Start----------");
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
  println("Xt:", xT);
  println("ppi", ppi);
  strokeWeight(1);
  stroke(255);
  //---------- measure lines
  while ((2*xT+xT2) > xT) {
    xT2 = xT2 - ppi;
    println("nw Xt:", xT2);
    translate(ppi, 0);
    line(box.xC, 0, box.xC, box.yS);
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
  println("xB - xA / ppi", xB, xA, ppi);
  println("Amplitude: ", fittsA);
}

void setups() {
  if (!Trial) Grid = !Grid;
  updateButtons();
  //if (Grid) {
  //  cp5.getController("bangOn").remove();
  //  cp5.getController("bangOff").remove();
  //}

  //cp5.getController("bangOn").setVisible(!Grid);
  //cp5.getController("bangOff").setVisible(!Grid);
  println("Grid:", Grid);
}

void startTrial() {
  Trial = !Trial; // toggle the Trial setting
  if (Trial) {


    trials++;

    println("start trial");
    samples = 0;
    start_time=millis();
    timer(true);
  } else {
    println("end trial");

    Started = false;
  }
}
