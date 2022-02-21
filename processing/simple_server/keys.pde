int samples = 0;
int trials = 0;
Boolean Trial = false;

void keyPressed() {
  println("key", key);

  switch(key) {
  case 't': 
    startTrial();
    break;
  case 1: 
    println("One");  // Prints "One"
    break;
  default:
    break;
  }
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
