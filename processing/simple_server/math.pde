import java.math.*;

public static float round(float d, int decimalPlace) {
  BigDecimal bd = new BigDecimal(Float.toString(d));
  bd = bd.setScale(decimalPlace, BigDecimal.ROUND_HALF_UP);
  return bd.floatValue();
}

int findLong(int i) {
  //int iLong;
  float buff = 0;
  if (i == 0) {
  } else {
    buff = ((xS/2 - bW/2 - gutter)*offset)*i;
  }

  return int(buff);
}

//=LOG(2*C3/D3, 2)
// log2 (2a/w)
//float findID(){
//  float result;
//  //float result = log2(2*fittsA/fittsW);
//  result = Math.log(2)(2*fittsA/fittsW);
//  println(".................",log(2*fittsA/fittsW));
//  return result;
//}

public static float log2(float x) {
    return round((float) (Math.log(x) / Math.log(2)+ 1e-10),2);
}
