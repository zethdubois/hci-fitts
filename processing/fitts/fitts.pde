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
AudioPlayer startClick, stopClick;


// network
Server s;
Client c;
String input;
int data[];
int xS = 100, yS = 100;
PFont bFont, nFont;

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
  bFont = createFont("Consolas Bold", tSize);
  nFont = createFont("Consolas", tSize);

  g = new GUIController (this);
  s = new Server(this, 12345);  // Start a simple server on a port
  cp5 = new ControlP5(this);   
  minim = new Minim(this);
  startClick = minim.loadFile("beep.wav");
  stopClick = minim.loadFile("boop.wav");
  updateButtons();
}


public void bangOffX() {
  if (Started) { // timer is counting...
    samples++;
  }

  Started = false;
  delay(1);
  stopClick.play();
  stopClick.rewind();
  println("timer stoped");
}


public void bangOnX() {
  //int theColor = (int)random(255);
  startClick.rewind();
  Started = true;
  start_time = millis();
  delay = 1;
  startClick.play();

  //cp5.getController("bangOn").setColorForeground(color(10,10,10));
  println("timer started");
  if (iMode==0) s.write(5);
}

void setArgs() {
  ppi = box.ppi;
  bW = box.bW1;
  println("..............bW", bW);
  xC = box.xC;
  yC = box.yC;
  xS = box.xS;
  yS = box.yS;
  tSize = box.tSize;
  offset = box.offset;
  mode = box.mode;
  network = box.network;
  if (mode.equals("single")) iMode = 1; 
  else iMode = 0;
  //if (server.equals("0")) server = "127.0.0.1";
}




PSurface initSurface() {
  cnfgs = new StringDict();
  cnfg = loadStrings(cFile);
  
  for (String buff : cnfg) {
    String[] args = buff.split("=");
    try {
      cnfgs.set(args[0], args[1]);
    }  
    catch(Exception e) {
    }
  }
  println("cnfgs: ", cnfgs);

  box = new Sandbox(cnfgs);
  setArgs();
  PSurface pSurface = super.initSurface();
  PSurfaceAWT awtSurface = (PSurfaceAWT) surface;
  SmoothCanvas smoothCanvas = (SmoothCanvas) awtSurface.getNative();
  Frame frame = smoothCanvas.getFrame();
  //frame.setUndecorated(true);
  pSurface.setResizable(true);
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
    if (!Grid) updateButtons();
  }
}

void showMode() {
  strokeWeight(6);
  if (Trial) stroke(250, 250, 0);
  if (Grid) stroke(250, 0, 0);
  noFill();
  rect(3, 3, xS-4, yS-4);
  strokeWeight(1);
  stroke(0);
}

void draw() {
  background(bgc);//refresh screen
  aparatus();
  showMode();
  timer(false);
  if (Grid) drawGrid();
  if (Grid) writeMsg();
  //  s.write(pmouseX + " " + pmouseY + " " + mouseX + " " + mouseY + "\n");

  //. Receive data from client
  c = s.available();
  if (c != null) {
    input = c.readString();
    input = input.substring(0, input.indexOf("\n"));  // Only up to the newline
    data = int(split(input, ' '));  // Split values into an array
  }
  if (!OverStop && !Grid && iMode == 1) {
    if (mouseX > b2x && mouseX < b2x+bW && 
      mouseY > b2y && mouseY < b2y+bW) {
      OverStop = true;
      OverStart = false;
      println("OverStop");
      bangOffX();
    } else {
      OverStop = false;
    }
  }
  if (!OverStart && !Grid) {
    if (mouseX > b1x && mouseX < b1x+bW && 
      mouseY > b1y && mouseY < b1y+bW) {
      OverStart = true;
      OverStop = false;
      println("OverStart");
      bangOnX();
    } else {
      OverStart = false;
    }
  }
}