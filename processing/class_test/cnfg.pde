//--initialize class dictionaries, Exp and Trial
//? questions exist
StringDict eCnfg;
StringDict tCnfg;
StringDict vCnfg;
String[] cnfg_buff;

String eFile = "exp.ini";
String tFile = "trials.ini";
String vFile = "valid.ini";

void loadValid() {
  vCnfg = new StringDict();
  cnfg_buff = loadStrings(vFile);
  for (String buff : cnfg_buff) {
    String[] args = buff.split(":");
    try {
      vCnfg.set(args[1], args[2]);
      println("look ",vCnfg.get("10"));
    }  
    catch(Exception e) {
    }
  }
  println("valid key states loaded from file: ", vCnfg);
}


//: create Experiment class from file
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
  E.goScreen();
}

//: create Trial class from file
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
  t = new Trial(tCnfg, i);
  T[i] = (t);
}
