AudioPlayer startClick, stopClick;
String fileName;
int fittsMT = 0;
int sampleSize = 15;

boolean GotData = false;

public void boop() {                    // STOP
  if (Started) { // timer is counting...
    samples++;
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
  if (samples >= sampleSize) {
    //Grid = true;
    samples = 0;
    setups();

  }
  /*
  {      
   samples = 0;
   println ("here it is!------------");
   int b = Integer.parseInt(bSelect);
   b ++;
   bSelect = String.valueOf(b); 
   Grid = true;
   switch (bSelect) { 
   case "2": 
   println("select button width");  
   setBW(box.bW2);
   bSelect = "2";
   break;
   case "3": 
   println("select button width");  
   setBW(box.bW3);
   bSelect = "3";
   break;
   case "4": 
   println("select button width");  
   setBW(box.bW4);
   bSelect = "4";
   break;
   }
   println(bSelect);
   Grid = false;
   }
   */
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

  if (!OverBoop && !Grid && !Dual) {
    if (mouseX > b2x && mouseX < b2x+bW && mouseY > b2y && mouseY < b2y+bW) {
      boop();
    } else {
      OverBoop = false;
    }
  }
  if (!OverBeep && !Grid) {
    if (mouseX > b1x && mouseX < b1x+bW && 
      mouseY > b1y && mouseY < b1y+bW) {

      beep();
    } else {
      OverBeep = false;
    }
  }
}
