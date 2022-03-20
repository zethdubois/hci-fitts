/* 
 ts_* : trial settings
 ex_* : experiment settings
 */

import java.math.*;

float [] ts_ID_arr;
float [] ts_A_arr;
float [] ts_bWi_arr;
float [] ts_bAi_arr;

float fittsTP() {
  float out = 0;
  //float out = fittsID/fittsMT*1000;  //convert to array
  return out;
}

float fittsA(int trial, String mode) {
  float out;
  int xT = findLong(Dual, 1, trial); //: get the first longitude 
  int xB = xT + xC;
  int xA = xC - xT; // long butt A

  if (mode.equals("pixels")) {
    out = round((float(xB) - float(xA)), 2);
  } else {
    out = round((float(xB) - float(xA)) / float(ppi), 2);
  }
  return out;
}

float fittsID(int trial) {
  println("\n-->fittsID(", trial);
  println(ts_bAp_arr[trial]);  
  println(ts_bWp_arr[trial]);
  float out = log2(ts_bAp_arr[trial]/ts_bWp_arr[trial]+1);
  println("ID = ", out);
  return out;
}
void calcID(String mode) {
  println("\n-->calcID("+mode+")");
  println("****EXIT HERE WHILE DEBUGGING****");
  boolean debug = true;
  if (debug) return;
  int j = ts_adj; 
  int k = ts_adj;

  if (mode.equals("PPI")) { // change all the ts's
    j=0;
    k=3;
  }
  for (int i=j; i<=k; i++) {
    println("i:", i);
    print("ts__arr:", ts_A_arr[i]);
    if (Dual) ts_ID_arr[i] = log2(ts_A_arr[i]/ts_bWi_arr[i]+1); 
    else ts_ID_arr[i] = log2(ts_A_arr[i]/ts_bWp_arr[i]+1);
    println("W", ts_bWi_arr[i]);
    println("ID=", ts_ID_arr[i]);
  }

  //fittsID = log2(fittsA/fittsW+1);
}

public static float round(float d, int decimalPlace) {
  BigDecimal bd = new BigDecimal(Float.toString(d));
  bd = bd.setScale(decimalPlace, BigDecimal.ROUND_HALF_UP);
  return bd.floatValue();
}

int findLong(boolean Switch, int i, int trial) {
  //println("\n-->findLong("+Switch, i, trial);
  //int iLong;
  float buff = 0;
  if (Switch) {
  } else {
    //println(ts_bWp_arr[trial]);
    buff = ((xS/2 - ts_bWp_arr[trial]/2 - gutter)*offset)*i;
  }

  return int(buff);
}

public static float log2(float x) {
  return round((float) (Math.log(x) / Math.log(2)+ 1e-10), 2);
}

public int boolToInt(boolean b) {
  return b ? 1 : 0;
}
