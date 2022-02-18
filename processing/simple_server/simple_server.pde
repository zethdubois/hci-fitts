//requires: controlP5

// 2A: Shared drawing canvas (Server)

// surface 1, client: 2736 x 1824 (267 ppi), 12.3 in display, 11.5 x 7.9
// surface go, server: 1800 x 1200, 46.18 sq inches
// https://www.alphachooser.com/tablet_computers--microsoft_surface_go--tablet_computer-specs-and-profile

import processing.net.*;
import controlP5.*;
import ddf.minim.*;

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

void setup() {
  //size(450, 255);
  fullScreen();
  //pixelDensity(2);
  background(204);
  stroke(0);
  cp5 = new ControlP5(this);   
  minim = new Minim(this);
  player = minim.loadFile("click.mp3");

  frameRate(5); // Slow it down a little
  s = new Server(this, 12345);  // Start a simple server on a port

  // change the trigger event, by default it is PRESSED.
  
  int cX = displayWidth / 2;
  int cY = displayHeight / 2;
  int w = 100;
  int h = 100;
  
  cp5.addSlider("size")
     .setPosition(100,140)
     .setSize(20,100)
     .setRange(0,255)
     .setNumberOfTickMarks(5)
     ;
     
  cp5.addBang("zero")
     .setPosition(cX-w, cY-h)
     .setSize(w, h)
     //.setTriggerEvent(Bang.RELEASE)
     .setLabel("RETURN")
     .updateSize()
     ;
  
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
