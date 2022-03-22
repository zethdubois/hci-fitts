
import java.io.*;
import java.lang.*;
import java.util.*;

String eFile = "exp.ini";
String tFile = "trials.ini";
StringDict eCnfg;
StringDict tCnfg;
String[] cnfg_buff;
Exp E;
Trial t;
Trial[] T;

void setup() {
  loadExp();
  T = new Trial[E.TPC];

  for (int i = 0; i < E.TPC; i++) {
    loadTrials(i);
  }
}

void draw() {
  println(E.CPE);
  println(T[0].SBWP);
  println(T[3].BWP);
}
