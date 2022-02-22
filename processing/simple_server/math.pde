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

public static float log2(float x) {
    return round((float) (Math.log(x) / Math.log(2)+ 1e-10),2);
}
