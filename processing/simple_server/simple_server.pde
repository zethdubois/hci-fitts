/*
How to run this experiment with two specified MS Surface computers
 surface 1, client: 2736 x 1824 (267 ppi), 12.3 in display, 11.5 x 7.9
 surface go, server: 1800 x 1200, 46.18 sq inches
 https://www.alphachooser.com/tablet_computers--microsoft_surface_go--tablet_computer-specs-and-profile
*/

// for window tweaks
import java.awt.Frame;
import processing.awt.PSurfaceAWT;
import processing.awt.PSurfaceAWT.SmoothCanvas;

//
import processing.net.*;
import controlP5.*;
import ddf.minim.*;
import interfascia.*;

String[] cnfg;
String cFile = "cnfg.ini";

GUIController g;
IFButton startButton, stopButton;
IFProgressBar progress;
IFCheckBox global, nothing;

IFLookAndFeel defaultLook, redLook, greenLook;
boolean running = false;

ControlP5 cp5;
Minim minim;
AudioPlayer player;


int myColorBackground = color(0, 0, 0);

color[] col = new color[] {
  color(100), color(150), color(200), color(250)
  };



  

Server s;
Client c;
String input;
int data[];
int xS = 100 , yS = 100;


//globals
float wSlideMod = 0.5;
float slideAspect = 0.05;

Sandbox box;

void setup() {
  size(100,100);
  background(20);
  

  
  
  g = new GUIController (this);
  s = new Server(this, 12345);  // Start a simple server on a port
  cp5 = new ControlP5(this);   
  minim = new Minim(this);
  player = minim.loadFile("click.mp3");

  //[xS, yS] = layout(sSet);
 
//  cp5.addBang("zero")
//     .setPosition(cX-wBang, cY-h)
//     .setSize(w, hBang)
//     //.setTriggerEvent(Bang.RELEASE)
//     .setLabel("RETURN")
//     .updateSize()
//     ;

}


PSurface initSurface() {
  cnfg = loadStrings(cFile);
  int sSet = int(cnfg[0]);  
  box = new Sandbox(sSet);
  println(box.xS);
  PSurface pSurface = super.initSurface();
  PSurfaceAWT awtSurface = (PSurfaceAWT) surface;
  SmoothCanvas smoothCanvas = (SmoothCanvas) awtSurface.getNative();
  Frame frame = smoothCanvas.getFrame();
  frame.setUndecorated(true);
  pSurface.setResizable(true);
  pSurface.setSize(box.xS, box.yS);
  return pSurface;
}
void addStart(){

}

void draw() {
  //the drawing sample code
  //if (mousePressed == true) {
  //  // Draw our line
  //  stroke(255);
  //  line(pmouseX, pmouseY, mouseX, mouseY);
  //  // Send mouse coords to other person
  //  s.write(pmouseX + " " + pmouseY + " " + mouseX + " " + mouseY + "\n");
  //}

  if (running) {
    progress.setProgress((progress.getProgress() + 0.01) % 1);
  }
  
  // Receive data from client
  c = s.available();
  if (c != null) {
    input = c.readString();
    input = input.substring(0, input.indexOf("\n"));  // Only up to the newline
    data = int(split(input, ' '));  // Split values into an array
    // Draw line using received coords
    stroke(0);
    line(data[0], data[1], data[2], data[3]);
  }
}

public void bang() {
  int theColor = (int)random(255);
  myColorBackground = color(theColor);
  println("### bang(). a bang event. setting background to "+theColor);
}


public void controlEvent(ControlEvent theEvent) {
  String name = theEvent.getController().getName();
  if (name.equals("zero")) {
    player.play();
    player.rewind();
    s.write(5);
  }
}

void removeStart(){
  g.remove(startButton);
  g.remove(stopButton);
  g.remove(progress);
  startButton = null;
  println("bye");

}


void actionPerformed (GUIEvent e) {
  if (e.getSource() == startButton) {
    running = true;
  } else if (e.getSource() == stopButton) {
    running = false;
    removeStart();
  } else if (e.getSource() == global && e.getMessage().equals("Checked")) {
      startButton.setLookAndFeel(defaultLook);
      stopButton.setLookAndFeel(defaultLook);
      global.setLookAndFeel(defaultLook);
      nothing.setLookAndFeel(defaultLook);
  } else if (e.getSource() == global && e.getMessage().equals("Unchecked")) {
      startButton.setLookAndFeel(greenLook);
      stopButton.setLookAndFeel(redLook);
      global.setLookAndFeel(greenLook);
      nothing.setLookAndFeel(greenLook);
  }
}
