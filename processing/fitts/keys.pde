int samples = 0;
int trials = 0;
Boolean Trial = false;
Boolean Grid = false;
float fittsA, fittsW; //: amplitude / width
int iMode;

color startColor = color(0, 255, 0);
color stopColor = color(255, 0, 0);
int b1x, b1y, b2x, b2y;

void testNet() {
  println("Test Network");
  s.write(5);
}
void keyPressed() {
  println("key", key);

  switch(key) {
  case 'n': 
    testNet();

    break;    
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
  case ';': 
    println("decrease spacing");  
    adjustOff(-.01);
    break;
  case '\'': 
    println("increase spacing");  
    adjustOff(.01);
    break;
  case ',': 
    println("decrease window");  
    adjustWin(-10);
    break;
  case '.': 
    println("increase window");  
    adjustWin(+10);
    break;
  case '1': 
    println("select button width");  
    setBW(box.bW1);
    bSelect = "1";
    break;
  case '2': 
    println("select button width");  
    setBW(box.bW2);
    bSelect = "2";
    break;
  case '3': 
    println("select button width");  
    setBW(box.bW3);
    bSelect = "3";
    break;
  case '4': 
    println("select button width");  
    setBW(box.bW4);
    bSelect = "4";
    break;
  case 'm': 
    println("toggle mode");  
    iMode = (iMode+1) % 2;
    if (!Grid) setups();
    //updateButtons();
    break;     
  default:
    break;
  }
}


void updateButtons() {
  println(" -> updateButtons(), mode=", mode);
  int test ;
  try {
    test = cp5.getController("bangOn").getId();
  } 
  catch(Exception e) {
    test = 0;
  }
  if (test != 0) {
    cp5.getController("bangOn").remove();
    try {
      cp5.getController("bangOff").remove();
    }
    catch(Exception e) {
    }
  } else {
    int xT = findLong(iMode);
    b1x = xC-bW/2-xT;
    b1y = yC-bW/2;
    b2x = xC-bW/2+xT;
    b2y = yC-bW/2;

    cp5.addBang("bangOn")
      .setPosition(b1x, b1y)
      .setSize(bW, bW)
      .setColorForeground(startColor)
      .setLabel("start")
      ;
    if (iMode == 1) {//(mode.equals("single")) {
      cp5.addBang("bangOff")
        .setPosition(b2x, b2y)
        .setSize(bW, bW)
        .setColorForeground(stopColor)
        .setLabel("stop")
        ;
    }
  }
}

void setups() {
  if (Started) {
    Started = false;
    OverStart=false;
    start_time = millis();
    timer(true);
    //timer(false);
    return;
  }
  if (!Trial) Grid = !Grid;
  println("Grid:", Grid);
  if (!Trial) updateButtons();
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