/*
[setup][viewing t][editng t][trialAct]
 1      2          3
 
 */
 

//: adjust trial, view trial
boolean Adjust = false;
boolean View = false;
int activeT = -1;
int kState = 0;



void setState() {
  int buff = (int)Math.pow(1,2)*-("false".indexOf("" + Adjust));//Boolean.compare(kState, Boolean.TRUE) + 1//BooleanUtils.toInteger(Adjust);
  kState = buff;
  println("kState:",kState);
}


public void viewT (int i) {
  activeT = i;
  View = true;
}

public void adjustT () {
  Adjust = !Adjust;
}
