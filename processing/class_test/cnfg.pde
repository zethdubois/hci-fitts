//--initialize class dictionaries, Exp and Trial
//? questions exist

void loadExp() {
  eCnfg = new StringDict();
  cnfg_buff = loadStrings(eFile);
  for (String buff : cnfg_buff) {
    String[] args = buff.split("=");
    try {
      eCnfg.set(args[0], args[1]);
      println(args[0], "=", args[1]);
    }  
    catch(Exception e) {
    }
  }
  println("experimental configs loaded from file: ", eCnfg);
  //? how to type cast dictionary pairs for solitary printout
  //String foo;
  //for (foo in eCnfg){}
  E = new Exp(eCnfg);
}


void loadTrials(int i) {
  tCnfg = new StringDict();
  cnfg_buff = loadStrings(tFile);
  for (String buff : cnfg_buff) {
    String[] args = buff.split("=");
    try {
      tCnfg.set(args[0], args[1]);
      println(args[0], "=", args[1]);
    }  
    catch(Exception e) {
    }
  }
  
  println("experimental configs loaded from file: ", tCnfg);
  t = new Trial(tCnfg,i);
  T[i] = (t);
}
