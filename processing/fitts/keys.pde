
Boolean Trial = false;
Boolean Setup = true;
float fittsA, fittsW; //: amplitude / width
int iMode = 0;
int iTrace =0;

color startColor = color(0, 255, 0);
color stopColor = color(255, 0, 0);
int b1x, b1y, b2x, b2y;


void testNet(String ip) {
  println("\n-->testNet("+ip+")");
  pingTime(ip);
  s.write(5);
}

void switchNet() {
  println("\n-->switchNet() /");
  println("> Wifi :", WiFi);
  WiFi = !WiFi;
  testNet(SERVER_arrP);
  setNet();
}

void keyPressed() {
  println("key", key);

  switch(key) {
  case 'n': 
    if (Dual) switchNet();
    break;   
  case 'c': 
    if (Setup && !Calibrated && Calibrate) {
      Calibrated = true;
      Calibrate = false;
      return;
    }

    if (Setup && Dual) {
      Calibrate=!Calibrate;
    }

    break;    
  case 't': 
    startTrial();
    break;
  case ' ':                       // SPACEBAR
    println("Setups");  
    setups();
    break;
  case '-': 
    println("decrease PPI");  
    adjustPPI(-1);
    calcID("PPI");
    break;
  case '=': 
    println("increase PPI");  
    adjustPPI(1);
    calcID("PPI");
    break;
  case '_': 
    println("decrease PPI");  
    adjustPPI(-10);
    calcID("PPI");
    break;
  case '+': 
    println("increase PPI");  
    adjustPPI(10);
    calcID("PPI");
    break;
  case '[': 
    println("decrease button size");  
    adjustBW(-1);
    calcID("width");
    break;
  case ']': 
    println("increase button size");  
    adjustBW(1);
    calcID("width");
    break;
  case '{': 
    println("decrease button size");  
    adjustBW(-10);
    calcID("width");
    break;
  case '}': 
    println("increase button size");  
    adjustBW(10);
    calcID("width");
    break;   
  case ';': 
    println("decrease amplitude");  
    adjustAmp(-.01);
    calcID("amp");
    break;
  case '\'': 
    println("increase spacing");  
    adjustAmp(.01);
    calcID("amp");
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
    // mode switch
  case 'm':
    if (Setup) toggleMode();

    //updateButtons();
    break;     
  default:
    break;
  }
  iTrace++;
  println("\n["+iTrace+"]---------------------");
}

void toggleMode() {
  println("\n-->toggle mode() /");
  println("> iMode : ", iMode);
  iMode = (iMode+1) % 3;
  println(">> iMode : ", iMode);

  if (iMode == 0) {
    Dual = false;
    mode = "single";
    es_unit = "pixels";
  }
  if (iMode == 1) {
    Dual = true;
    es_unit = "inches";
    if (!Calibrated) Calibrate = true;
    mode = "server";
  }
  if (iMode == 2) {
    Dual = true;
    if (!Calibrated) Calibrate = true;
    mode = "client";
    es_unit = "inches";
  }
  setNet();
  if (GotData) {
    GotData = false;
    writeData();
    return;
  }
  if (!Setup) setups();
}
void updateButtons() {
  println(" -> updateButtons(), mode=", mode);
  int test ;
  try {
    test = cp5.getController("bangBeep").getId();
  } 
  catch(Exception e) {
    test = 0;
  }
  if (test != 0) {
    cp5.getController("bangBeep").remove();
    try {
      cp5.getController("bangBoop").remove();
    }
    catch(Exception e) {
    }
  } else {
    int xT = findLong(Dual, 1, whichTrial);
    b1x = xC-bW/2-xT;
    b1y = yC-bW/2;
    b2x = xC-bW/2+xT;
    b2y = yC-bW/2;

    cp5.addBang("bangBeep")
      .setPosition(b1x, b1y)
      .setSize(bW, bW)
      .setColorForeground(startColor)
      .setLabel("start")
      ;
    if (!Dual) {
      cp5.addBang("bangBoop")
        .setPosition(b2x, b2y)
        .setSize(bW, bW)
        .setColorForeground(stopColor)
        .setLabel("stop")
        ;
    }
  }
}

void getParticipant() {
}
void setups() {
  if (Started) {
    Started = false;
    OverBeep=false;
    start_time = millis();
    timer(true);
    return;
  }
  if (!Trial) Setup = !Setup;
  println("Setup:", Setup);
  if (!Trial) updateButtons();
}

void startTrial() {
  if (!Setup) Trial = !Trial; // toggle the Trial setting
  if (Trial) {
    ex_trialCnt++;
    println("start trial");
    ex_sampleCnt = 0;
    start_time=millis();
    timer(true);
  } else {
    println("end trial");
    Started = false;
  }
}
