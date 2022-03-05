boolean Started = false;
int sec = 0;
int millisec = 0;
int start_time = 0;
int delay = 0;
boolean InitGui = true;
int startX, startY;      // Position of square button
int stopX, stopY;  // Position of stop button
int startSize = 90;     // Diameter of start
int stopSize = 90;   // Diameter of stop
color startHighlight, stopHighlight;
color currentColor;
boolean startOver = false;
boolean stopOver = false;
String sTxt, tTxt;
int gutter = 20;
long sampleTime;

void timer(boolean Zero) { // Zero = true to reset
  if (Grid) return;
  if (Started || Zero) {//keep track of time values after pressed only works for an hour
    millisec = (millis() - start_time);// % 1000;

    //sec = int((millis() - start_time)/1000) % 60;
  }
  fittsMT = millisec;
  sampleTime = getUnix();
  fill(255);
  String timeOut = "Movement Time: "+fittsMT+" msec";
  text(timeOut, gutter, 100);//display the times on the interface
  //text(sec, 60, 100);
  //text(".", 80, 100);
}


void aparatus() {
  //textSize(box.tSize);
  textFont(nFont);
  sTxt = "Sample # "+samples;
  tTxt = "Trial # "+trials;  
  int xT;

  if (!Grid) {
    if (Trial) {
      text(tTxt, gutter, 30);  // trial #
    }
    text(sTxt, gutter, 60);    // sample #
  }
  if (delay == 1) {//delay after a button press before it becomes resposive again
    if (millis() - start_time >= 400) {
      delay = 0;
    }
  }
}
