AudioPlayer startClick, stopClick;
String fileName;
int fittsMT = 0;

boolean GotData = false;

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

void nextCondtion(){
  ex_condStr = conditions[ex_condCnt];
}
public void beep() {                 // START 
  //int theColor = (int)random(255);
  if (NewFile) {
    Date now = new Date();
    long ut3 = now.getTime() / 1000L;
    fileName = Long.toString(ut3);
    System.out.println(ut3);
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
