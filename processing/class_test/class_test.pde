//? questions exist
// for window tweaks

import java.awt.Frame;
import processing.awt.PSurfaceAWT;
import processing.awt.PSurfaceAWT.SmoothCanvas;

StringDict eCnfg;
StringDict tCnfg;
String[] cnfg_buff;
Exp E;
Trial t;
Trial[] T;

void setup() {
  //: instantiate trial class objects; E.TPC instructs how many
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

PSurface initSurface() {
  //: create experiment class from file
  loadExp();

  PSurface pSurface = super.initSurface();
  PSurfaceAWT awtSurface = (PSurfaceAWT) surface;
  SmoothCanvas smoothCanvas = (SmoothCanvas) awtSurface.getNative();
  Frame frame = smoothCanvas.getFrame();
  if (E.screen == 0) frame.setUndecorated(true); 
  else if (E.resizable) pSurface.setResizable(true);
  //registerMethod("pre", this); //? from old Fitts initSurface, may need it?
  pSurface.setSize(E.xS, E.yS);
  return pSurface;



}
