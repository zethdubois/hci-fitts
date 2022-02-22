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

void timer(boolean Zero){
  if (Grid) return;
  if (Started || Zero) {//keep track of time values after pressed only works for an hour
    millisec = (millis() - start_time) % 1000;
    sec = int((millis() - start_time)/1000) % 60;
    
  }
  fill(255);
  text(millisec,100,100);//display the times on the interface
  text(sec,60,100);
  text(":",50,100);
  text(":",90,100);
  text("sec",50,80);
  text("ms",100,80); 
}

int findLong(int i){
  //int iLong;
  float buff = 0;
  if (i == 0){
  }else{
    buff = ((box.xS/2 - box.bW/2 - gutter)*box.offset)*i;
  }
  
  return int(buff);
}
void aparatus(){
  //textSize(box.tSize);
  textFont(nFont);
  sTxt = "Sample # "+samples;
  tTxt = "Trial # "+trials;  
  int xT;
  
  //! played with setting different colors for the buttons, depending on timer, decided against it fo rnow
  //if (Started == 0){
  //  startC=color(0,255,0);
  //  stopC=color(90,0,0);
  //}

  if (!Grid){
    if (Trial){
      text(tTxt,50,30);  // trial #
    }
    text(sTxt,50,60);    // sample #
  }
  if (delay == 1) {//delay after a button press before it becomes resposive again
    if (millis() - start_time >= 400) {
      delay = 0;
    }
  }


  if (InitGui == true){
    fill(startColor);

    xT = findLong(1);
    

    translate(int(xT*2), 0);
    fill(stopColor);
    



    InitGui = false;
  }

//ellipse(stopX, stopY, stopSize, stopSize);


//  pushMatrix();
//  translate(int(-1*xT), 0);
//  fill(startC);
//  ellipse(box.xC,box.yC,box.bW,box.bW);
//  translate(int(xT*2), 0);
//  fill(stopC);
//  ellipse(box.xC,box.yC,box.bW,box.bW);
//  popMatrix();
  
  

  
}




void mousePressed() {
  if (stopOver) {
    currentColor = stopColor;
  }
  if (startOver) {
    currentColor = startColor;
  }
}

boolean overstop(int x, int y, int diameter) {
  float disX = x - mouseX;
  float disY = y - mouseY;
  if (sqrt(sq(disX) + sq(disY)) < diameter/2 ) {
    return true;
  } else {
    return false;
  }
}

boolean overstart(int x, int y, int diameter) {
  float disX = x - mouseX;
  float disY = y - mouseY;
  if (sqrt(sq(disX) + sq(disY)) < diameter/2 ) {
    return true;
  } else {
    return false;
  }
}
