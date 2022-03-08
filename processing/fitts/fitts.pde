/*
How to run this experiment with two specified MS Surface computers
 surface 1, client: 2736 x 1824 (267 ppi), 12.3 in display, 11.5 x 7.9
 surface go, server: 1800 x 1200, 46.18 sq inches
 https://www.alphachooser.com/tablet_computers--microsoft_surface_go--tablet_computer-specs-and-profile
 */

import java.io.*;
import java.lang.*;
import java.util.*;

// for window tweaks
import java.awt.Frame;
import processing.awt.PSurfaceAWT;
import processing.awt.PSurfaceAWT.SmoothCanvas;

//
import processing.net.*;
import controlP5.*;
import ddf.minim.*;
import interfascia.*;

// init file
String[] cnfg;
String cFile = "cnfg.ini";
StringDict cnfgs;
String server;

// objects
Sandbox box;
GUIController g;
IFButton startButton, stopButton;
IFProgressBar progress;
IFCheckBox global, nothing;

//boolean running = false;

ControlP5 cp5;
Minim minim;



Server s;
Client c;
String input;
int data[];
int xS = 100, yS = 100;
PFont bFont, nFont, iFont;

/// style vars
float wSlideMod = 0.5;
float slideAspect = 0.05;

int bgc = 20; //: background color
int myColorBackground = color(0, 0, 0);

color[] col = new color[] {
  color(100), color(150), color(200), color(250)
};

//! get list of fonts...
//String[] fontList = PFont.list();
//println(fontList);

void setup() {
  size(1000, 1000);
  fill(0);//black text color
  ellipseMode(CENTER);
  bFont = createFont("Monospaced", tSize+2);
  nFont = createFont("Monospaced", tSize);
  iFont = createFont("Verdana", tSize+1);
  g = new GUIController (this);
  s = new Server(this, 12345);  // Start a simple server on a port
  cp5 = new ControlP5(this);   
  minim = new Minim(this);
  startClick = minim.loadFile("beep.wav");
  stopClick = minim.loadFile("boop.wav");
  fileName = "test"; //+fileName;
  setupFile(fileName);
  //updateButtons();
}





void setArgs() {
  ppi = box.ppi;
  bW = box.bW1;
  xC = box.xC;
  yC = box.yC;
  xS = box.xS;
  yS = box.yS;
  tSize = box.tSize;
  offset = box.offset;
  mode = box.mode;
  network = box.network;
  screen = box.screen;
  es_numSPT = int(cnfgs.get("number_of_samples_per_trial"));
  es_condition1 = cnfgs.get("condition1");
  es_condition2 = cnfgs.get("condition2");
  es_condition3 = cnfgs.get("condition3");
  conditions = new String[]{es_condition0, es_condition1, es_condition2, es_condition3};
  es_numTPC = int(cnfgs.get("number_of_trials_per_condition"));
  Resize = Boolean.parseBoolean(cnfgs.get("resize"));
  if (mode.equals("server")) {
    iMode = 1;
    Dual = true;
  }
  if (mode.equals("client")) {
    Dual = true;
    iMode = 2;
  }
  if (network.equals("wifi")) WiFi = true;

  if (!Dual) network = "<n/a>";
  setNet();
  lf = int(tSize * lfMod);
  
  if (cnfgs.get("mode").equals("single")) es_unit="pixel"; else es_unit="inch";
  //pingTime(HOST_IP);
}

boolean Resize; // can set this in .ini. Concern that a participant could resize a window during trial, mess it up.
int numTrials;

PSurface initSurface() {
  cnfgs = new StringDict();
  cnfg = loadStrings(cFile);

  for (String buff : cnfg) {
    String[] args = buff.split("=");
    try {
      cnfgs.set(args[0], args[1]);
      println(args[0],"=",args[1]);
    }  
    catch(Exception e) {
    }
  }
  println("cnfgs loaded: ", cnfgs);

  box = new Sandbox(cnfgs);
  setArgs();
  PSurface pSurface = super.initSurface();
  PSurfaceAWT awtSurface = (PSurfaceAWT) surface;
  SmoothCanvas smoothCanvas = (SmoothCanvas) awtSurface.getNative();
  Frame frame = smoothCanvas.getFrame();
  if (screen == 0) frame.setUndecorated(true); 
  else if (Resize) pSurface.setResizable(true);
  registerMethod("pre", this);
  pSurface.setSize(xS, yS);
  return pSurface;
}

String ws = "";
void pre() {
  if (xS != width || yS != height) {
    // Sketch window has resized
    xS = width;
    yS = height;
    xC = xS / 2;
    yC = yS / 2;
    ws = "Size = " +xS + " x " + yS + " pixels";
    // Do what you need to do here
    println("resized!!!!!", ws);
    if (!Setup) updateButtons();
  }
}
color BLUE = color(0, 60, 255);
color YELLOW = color(255, 255, 0);
color RED = color(255, 0, 0);
color OFFWHITE = color(200, 200, 200);


void draw() {
  background(bgc);//refresh screen
  aparatus();
  showMode();
  timer(false);
  if (Setup) drawGrid();
  if (Setup) writeMsg();
  //  s.write(pmouseX + " " + pmouseY + " " + mouseX + " " + mouseY + "\n");

  //. Receive data from client
  c = s.available();
  if (c != null) {
    input = c.readString();
    input = input.substring(0, input.indexOf("\n"));  // Only up to the newline
    data = int(split(input, ' '));  // Split values into an array
  }
  checkClick();
}
