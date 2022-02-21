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

// objects
Sandbox box;
GUIController g;
IFButton startButton, stopButton;
IFProgressBar progress;
IFCheckBox global, nothing;

//boolean running = false;

ControlP5 cp5;
Minim minim;
AudioPlayer player, player2;

 
// network
Server s;
Client c;
String input;
int data[];
int xS = 100 , yS = 100;


/// style vars
float wSlideMod = 0.5;
float slideAspect = 0.05;

int bgc = 20; //: background color
int myColorBackground = color(0, 0, 0);

color[] col = new color[] {
  color(100), color(150), color(200), color(250)
  };



void setup() {
  size(1000,1000);
  fill(0);//black text color
  textSize(40);
  ellipseMode(CENTER);

  g = new GUIController (this);
  s = new Server(this, 12345);  // Start a simple server on a port
  cp5 = new ControlP5(this);   
  minim = new Minim(this);
  player = minim.loadFile("click.mp3");
  player2 = minim.loadFile("click2.mp3");
}


public void bangOn() {
  int theColor = (int)random(255);
  bgc = color(theColor);
  println("### bang(). a bang event. setting background to "+theColor);
}


PSurface initSurface() {
  cnfgs = new StringDict();
  cnfg = loadStrings(cFile);
  for (String buff : cnfg){
    String[] args = buff.split("=");
    cnfgs.set(args[0],args[1]);
  }
  println("cnfgs: ",cnfgs);
  box = new Sandbox(cnfgs);
  PSurface pSurface = super.initSurface();
  PSurfaceAWT awtSurface = (PSurfaceAWT) surface;
  SmoothCanvas smoothCanvas = (SmoothCanvas) awtSurface.getNative();
  Frame frame = smoothCanvas.getFrame();
  frame.setUndecorated(true);
  pSurface.setResizable(true);
  pSurface.setSize(box.xS, box.yS);
  return pSurface;
}

void draw() {
  background(bgc);//refresh screen
  timer();
  //  s.write(pmouseX + " " + pmouseY + " " + mouseX + " " + mouseY + "\n");
  
  //. Receive data from client
  c = s.available();
  if (c != null) {
    input = c.readString();
    input = input.substring(0, input.indexOf("\n"));  // Only up to the newline
    data = int(split(input, ' '));  // Split values into an array
  }
}
