int started = 0;
int sec = 0;
int min = 0;
int millisec = 0;
int start_time = 0;
int delay = 0;
color startC, stopC;

void timer(){
  textSize(box.tSize);
  int gutter = 20;
  int cOn = 255;  //. color on
  int cOff = 127;  //. color off
  startC = color(0,90,0);
  stopC = color(255,0,0);
  
  text("Timer",150,60);//display main text
  if (delay == 1) {//delay after a button press before it becomes resposive again
    if (millis() - start_time >= 400) {
      delay = 0;
    }
  }
  float xT = (box.xS/2 - box.bWset/2 - gutter)*box.offset;
  if (started == 0){
    startC=color(0,255,0);
    stopC=color(90,0,0);
  }
  translate(int(-1*xT), 0);
  fill(startC);
  ellipse(box.xC,box.yC,box.bWset,box.bWset);
  translate(int(xT*2), 0);
  fill(stopC);
  ellipse(box.xC,box.yC,box.bWset,box.bWset);    
  
  
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
  if (mousePressed == true) {//check if mouse was pressed on the start button
    loadPixels();
    println("Red: "+red(pixels[mouseX + mouseY * width]));
    println("Green: "+green(pixels[mouseX + mouseY * width]));
    println("Blue: "+blue(pixels[mouseX + mouseY * width]));
    if (green(pixels[mouseX + mouseY * width]) == 255){
      started = -1*started + 1;
      start_time = millis();
      delay = 1;//make sure after button is pressed it cant be pressed for a certain amount of time
      player.play();
      player.rewind();
      s.write(5);
    }
    if (red(pixels[mouseX + mouseY * width]) >= 200){
      started = -1*started + 1;
      start_time = millis();
      delay = 1;//make sure after button is pressed it cant be pressed for a certain amount of time
      player2.play();
      player2.rewind();
      s.write(5);      
    }      
  }
}

public void XmouseMoved()
    {
        loadPixels();
        println("Red: "+red(pixels[mouseX + mouseY * width]));
        println("Green: "+green(pixels[mouseX + mouseY * width]));
        println("Blue: "+blue(pixels[mouseX + mouseY * width]));
        println();
    }
