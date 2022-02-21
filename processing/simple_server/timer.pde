int started = 0;
int sec = 0;
int min = 0;
int millisec = 0;
int start_time = 0;
int delay = 0;
color startC, stopC;
boolean InitGui = true;
int startX, startY;      // Position of square button
int stopX, stopY;  // Position of stop button
int startSize = 90;     // Diameter of start
int stopSize = 90;   // Diameter of stop
color startColor, stopColor, baseColor;
color startHighlight, stopHighlight;
color currentColor;
boolean startOver = false;
boolean stopOver = false;


void timer(){
  textSize(box.tSize);
  int gutter = 20;

  startC = color(0,90,0);
  stopC = color(255,0,0);
  
  if (started == 0){
    startC=color(0,255,0);
    stopC=color(90,0,0);
  }  
  text("Timer",150,60);//display main text
  if (delay == 1) {//delay after a button press before it becomes resposive again
    if (millis() - start_time >= 400) {
      delay = 0;
    }
  }
  float xT = (box.xS/2 - box.bWset/2 - gutter)*box.offset;
  if (InitGui == true){
    fill(startC);

    pushMatrix();
    translate(int(-1*xT), 0);
    
    cp5.addBang("bangOn")
      .setPosition(box.xC-box.bWset/2-xT,box.yC-box.bWset/2)
      .setSize(box.bWset,box.bWset)
      .setColorForeground(startC)
      
      .setLabel("start")
     ;
    translate(int(xT*2), 0);
    fill(stopC);
    
    cp5.addBang("bangOff")
      .setPosition(box.xC-box.bWset/2+xT,box.yC-box.bWset/2)
      .setSize(box.bWset,box.bWset)
      .setColorForeground(stopC)
      .setLabel("stop")
     ;

    popMatrix();

    InitGui = false;
  }

  
  //  if (startOver) {
  //  fill(startHighlight);
  //} else {
  //  fill(startColor);
  //}
  //stroke(255);
  //ellipse(startX, startY, startSize, startSize);
  
  //if (stopOver) {
  //  fill(stopHighlight);
  //} else {
  //  fill(stopColor);
  //}
  //stroke(0);
  //ellipse(stopX, stopY, stopSize, stopSize);


//  pushMatrix();
//  translate(int(-1*xT), 0);
//  fill(startC);
//  ellipse(box.xC,box.yC,box.bWset,box.bWset);
//  translate(int(xT*2), 0);
//  fill(stopC);
//  ellipse(box.xC,box.yC,box.bWset,box.bWset);
//  popMatrix();
  
  
  if (started == 1) {//keep track of time values after pressed only works for an hour
    millisec = (millis() - start_time) % 1000;
    sec = int((millis() - start_time)/1000) % 60;
    min = int((millis() - start_time)/(60*1000)) % 60;
  }
  fill(255);
  text(millisec,220,200);//display the times on the interface
  text(sec,180,200);
  text(min,140,200);
  text(":",170,200);
  text(":",210,200);
  text("min",120,180);
  text("sec",170,180);
  text("ms",220,180);
  
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
