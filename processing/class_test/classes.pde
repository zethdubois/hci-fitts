//? questions exist

class Exp {
  //private String name; //? what is that for?
  int SPT, TPC, CPE;
  String cond1, cond2, cond3;

  Exp(StringDict cnfg) {
    CPE = int(cnfg.get("conditions_per_experiment"));
    TPC = int(cnfg.get("trials_per_condition"));
    SPT = int(cnfg.get("samples_per_trial"));

    cond1 = cnfg.get("condition1");
    cond2 = cnfg.get("condition2");
    cond3 = cnfg.get("condition3");
  }
}

class Trial {
  /* VARS:
  Button Width Pixels/Inches, 
  Button Spacing, 
  Start Button Width Pixels */
  
  int SBWP, BWP, BS;
  float BWI;

  Trial(StringDict cnfg, int i) {
    SBWP = int(cnfg.get("start_button_width"));
    BWP = int(cnfg.get("button_width_"+(i+1)));
    BS = int(cnfg.get("spacing_"+(i+1)));
  }
}
