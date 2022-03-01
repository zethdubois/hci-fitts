PrintWriter output;

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
