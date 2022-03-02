PrintWriter output;
boolean NewFile = true;

import java.time.Instant;
import java.util.Date;



void setupFile(String exp){
  println("\n--> setupFile("+exp+")");
  exp = exp+".txt";
  output = createWriter(exp);
}

void writeData(String exp){
  //crash
  println("\n--> writeData("+exp+")");
  output.flush();
  output.close();
}
