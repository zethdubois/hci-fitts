/* 
 ts_* : trial settings
 ex_* : experiment settings
 */

import java.math.*;

float [] ts_ID_I;
float [] ts_A_I;
float [] ts_bWi_I;

float fittsTP() {
  float out = fittsID/fittsMT*1000;
  return out;
}

void calcID(String mode) {
  println("\n-->calcID("+mode+")");
  int j = ts_adj; 
  int k = ts_adj;
  if (mode.equals("PPI")) { // change all the ts's
    j=0;
    k=3;
  }
  for (int i=j; i<=k; i++) {
    println("i:", i);
    if (Dual) ts_ID_I[i] = log2(ts_A_I[i]/ts_bWi_I[i]+1); else ts_ID_I[i] = log2(ts_A_I[i]/ts_bWp_I[i]+1);
    println("W", ts_bWi_I[i]);
    println("ID=", ts_ID_I[i]);
  }

  //fittsID = log2(fittsA/fittsW+1);
  //boo
}

public static float round(float d, int decimalPlace) {
  BigDecimal bd = new BigDecimal(Float.toString(d));
  bd = bd.setScale(decimalPlace, BigDecimal.ROUND_HALF_UP);
  return bd.floatValue();
}

int findLong(boolean Switch, int i) {
  //int iLong;
  float buff = 0;
  if (Switch) {
  } else {
    buff = ((xS/2 - bW/2 - gutter)*offset)*i;
  }

  return int(buff);
}

public static float log2(float x) {
  return round((float) (Math.log(x) / Math.log(2)+ 1e-10), 2);
}

public int boolToInt(boolean b) {
  return b ? 1 : 0;
}
