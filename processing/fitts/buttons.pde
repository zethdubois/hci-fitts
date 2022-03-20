AudioPlayer startClick, stopClick;
String fileName;
int fittsMT = 0;

boolean GotData = false;

void esButton(int i){
  //println("\n-->esButton(",i);
  int B = tSize+4; // size of the rectangle "button" to draw
  fill(TERMINAL,120);
  rectMode(CENTER);
  stroke(ROSE);
  rect(gutter*2,-lf*.3,B,B); //<>//
  fill(MGREEN);
  textFont(iFont);
  textAlign(CENTER);
  text((i+1),gutter*2,0);
  textAlign(RIGHT);
  textFont(nFont);
}
//!can't figure out how to get the stupid matrix coordinates caputred in a variable
//void esButtonX(int i) {
//  int b = 50;
//  String bangStr = "bang"+i;
//  resetMatrix();
//  PMatrix get()
//  PMatrix m = pg.getMatrix();
//  // isolate coordinate space
//  pushMatrix();
//  //apply last PGraphics matrix
//  applyMatrix(m);
//  cp5.addBang(bangStr)
//    .setPosition(0, 0)
//    .setSize(b, b)
//    //.setColorForeground(startColor)
//    .setLabel(Integer.toString(i))
//    ;
//}
public void boop() {                    // STOP
  if (Started) { // timer is counting...
    ex_sampleCnt++;
    GotData = true;
  }
  OverBoop = true;
  OverBeep = false;
  println("OverBoop");
  println("fittsMT:", fittsMT);
  Started = false;
  fittsTP = fittsTP();
  writeData();
  delay(1);
  stopClick.play();
  stopClick.rewind();
  println("timer stoped");
  if (ex_sampleCnt == es_numSPT && ex_condCnt != 0) {  //: next trial
    nextTrial();
  }
}

void nextTrial() {
  println("\nCongrats, you completed Trial # ", ex_trial);
  Trial=false;
  if (ex_trialCnt == es_numTPC) {
    nextCondtion();
  } else {
    startTrial();
  }
}

void nextCondtion() {
  ex_condStr = conditions[ex_condCnt];
}
public void beep() {                 // START 
  //int theColor = (int)random(255);
  if (NewFile) {
    Date now = new Date();
    long ut3 = now.getTime() / 1000L;
    fileName = Long.toString(ut3);
    println(ut3);
  }
  OverBeep = true;
  OverBoop = false;
  println("OverBeep");
  startClick.rewind();
  Started = true;
  start_time = millis();
  delay = 1;
  startClick.play();
  trial ++;
  //cp5.getController("bangBeep").setColorForeground(color(10,10,10));
  println("timer started");
  if (Dual) s.write(5);
}

void checkClick() {

  if (!OverBoop && !Setup && !Dual) {
    if (mouseX > b2x && mouseX < b2x+bW && mouseY > b2y && mouseY < b2y+bW) {
      boop();
    } else {
      OverBoop = false;
    }
  }
  if (!OverBeep && !Setup) {
    if (mouseX > b1x && mouseX < b1x+bW && 
      mouseY > b1y && mouseY < b1y+bW) {

      beep();
    } else {
      OverBeep = false;
    }
  }
}
