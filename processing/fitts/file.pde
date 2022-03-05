PrintWriter output;
boolean NewFile = true;
String participant = "anon";
String condition = "mouse";


import java.time.Instant;
import java.util.Date;
int trial = 0;

long getUnix() {
  long ut = Instant.now().getEpochSecond();
  //System.out.println(ut);
  return ut; //Long.toString(ut);
}

void setupFile(String exp) {
  println("\n--> setupFile("+exp+")");
  exp = exp+".csv";
  output = createWriter(exp);
  output.print("participant\t");
  output.print("condtion\t");
  output.print("amplitude\t");
  output.print("width\t");
  output.print("ID\t");
  output.print("trial\t");  
  output.print("MT\t");
  output.println("TP");  


  output.flush();
  //output.close();
}

void writeData() { //String exp) {
  //crash
  println("\n--> writeData()");
  println("Time Data:", timeData);
  output.print(participant+"\t");
  output.print(condition+"\t");
  output.print(fittsA+"\t");  
  output.print(fittsW+"\t");
  output.print(fittsID+"\t"); 

  output.print(trial+"\t");  
  output.print(timeData+"\t");
  output.println(fittsTP);  

  output.flush();
}

void closeTrial(String exp) {
  output.close();
}
