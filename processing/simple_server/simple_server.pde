//requires: controlP5

// 2A: Shared drawing canvas (Server)

// surface 1, client: 2736 x 1824 (267 ppi), 12.3 in display, 11.5 x 7.9
// surface go, server: 1800 x 1200, 46.18 sq inches
// https://www.alphachooser.com/tablet_computers--microsoft_surface_go--tablet_computer-specs-and-profile

import processing.net.*;
import controlP5.*;
import ddf.minim.*;
import interfascia.*;

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

//globals
float wSlideMod = 0.5;
float slideAspect = 0.05;


void setup() {
  fullScreen(2);
  background(20);
  //frameRate(5); // Slow it down a little

  g = new GUIController (this);
  s = new Server(this, 12345);  // Start a simple server on a port
  cp5 = new ControlP5(this);   
  minim = new Minim(this);
  player = minim.loadFile("click.mp3");
  
  stopButton = new IFButton ("Stop", 60, 70, 40, 17);
  progress = new IFProgressBar (120, 72, 70);
  global = new IFCheckBox ("Use global look and feel", 10, 15);

  

  global.addActionListener(this); 
  
  defaultLook = new IFLookAndFeel(this, IFLookAndFeel.DEFAULT);
  
  greenLook = new IFLookAndFeel(this, IFLookAndFeel.DEFAULT);
  greenLook.baseColor = color(100, 180, 100);
  greenLook.highlightColor = color(70, 135, 70);
  
  redLook = new IFLookAndFeel(this, IFLookAndFeel.DEFAULT);
  redLook.baseColor = color(175, 100, 100);
  redLook.highlightColor = color(175, 50, 50);
  
  //calculate center of screen
  int cX = displayWidth / 2;
  int cY = displayHeight / 2;

  stopButton.setLookAndFeel(redLook);

  //calculate slider size and position
  float w = wSlideMod * displayWidth;
  float h = w * slideAspect;
  float pX = cX - w/2;
  float pY = displayHeight - h * 2;
  
  cp5.addSlider("size")
     .setPosition(int(pX), int(pY))
     .setSize(int(w),int(h))
     .setRange(0,255)
     .setNumberOfTickMarks(5)
     ;


  

  stopButton.addActionListener(this);

  

  g.add (stopButton);
  g.add (progress);
//  cp5.addBang("zero")
//     .setPosition(cX-wBang, cY-h)
//     .setSize(w, hBang)
//     //.setTriggerEvent(Bang.RELEASE)
//     .setLabel("RETURN")
//     .updateSize()
//     ;
  addStart();
}


void addStart(){
  //calculate start
  int w = 100;
  int h = 100;

  float x = displayWidth / 2 - w / 2;
  float y = displayHeight / 2 - h / 2;

  startButton = new IFButton ("Start", int(x), int(y), int(w), int(h));  
  g.add (startButton);
  startButton.addActionListener(this);
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
  confirmGuiEvent = null;
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
