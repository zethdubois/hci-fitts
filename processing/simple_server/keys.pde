int samples = 0;
int trials = 0;
Boolean Trial = false;
Boolean Grid = false;

void keyPressed() {
  println("key", key);

  switch(key) {
  case 't': 
    startTrial();
    break;
  case ' ': 
    println("Setups");  
    setups();
    break;
  default:
    break;
  }
}

void drawGrid(){
  print("Drawgrid Start----------");
  int xT = findLong(1);
  int xT2 = xT;
  stroke(255);
  fill(255);
  pushMatrix();
  translate(-1*xT, 0);

  line(box.xC,0,box.xC,box.yS);
  println("Xt:",xT);
  println("ppi",box.ppi);
  
  while((2*xT+xT2) > xT){
  xT2 = xT2 - box.ppi;
  println("nw Xt:",xT2);
  translate(box.ppi, 0);
  line(box.xC,0,box.xC,box.yS);
  }
  popMatrix();
  pushMatrix();
  stroke(color(0,0,255));
  translate(xT, 0);
  line(box.xC,0,box.xC,box.yS); 
  popMatrix();
}

void setups(){
  if (!Trial) Grid = !Grid;
  println("Grid:",Grid);
}
void startTrial(){
  Trial = !Trial; // toggle the Trial setting
  if (Trial){
 
      
    trials++;

    println("start trial");
    samples = 0;
    start_time=millis();
    timer(true);
    
  }else{
    println("end trial");
    
  Started = false;
  }
}
