AudioPlayer startClick, stopClick;

boolean gotData = false;

public void bangOffX() {
  if (Started) { // timer is counting...
    samples++;
    gotData = true;
  }
  Started = false;
  delay(1);
  stopClick.play();
  stopClick.rewind();
  println("timer stoped");
  output.println(millisec);
}


public void bangOnX() {
  //int theColor = (int)random(255);
  startClick.rewind();
  Started = true;
  start_time = millis();
  delay = 1;
  startClick.play();

  //cp5.getController("bangOn").setColorForeground(color(10,10,10));
  println("timer started");
  if (Dual) s.write(5);
}

void checkClick() {

  if (!OverStop && !Grid && !Dual) {
    if (mouseX > b2x && mouseX < b2x+bW && 
      mouseY > b2y && mouseY < b2y+bW) {
      OverStop = true;
      OverStart = false;
      println("OverStop");
      bangOffX();
    } else {
      OverStop = false;
    }
  }
  if (!OverStart && !Grid) {
    if (mouseX > b1x && mouseX < b1x+bW && 
      mouseY > b1y && mouseY < b1y+bW) {
      OverStart = true;
      OverStop = false;
      println("OverStart");
      bangOnX();
    } else {
      OverStart = false;
    }
  }
}
