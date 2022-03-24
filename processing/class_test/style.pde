import controlP5.*;
import ddf.minim.*;

ControlP5 cp5;
Minim minim;

PFont nFont, iFont;
AudioPlayer startClick, stopClick;

//: CONSTANTS

String FRAME = "FRAME";
String BOLD = "BOLD";
String TITLE = "TITLE";
String NONE = "NONE";
boolean ON = true;
boolean OFF = false;


void style() {
  nFont = createFont("Monospaced", E.TS);
  iFont = createFont("Verdana", E.TS+1);
  cp5 = new ControlP5(this);   
  minim = new Minim(this);
  startClick = minim.loadFile("beep.wav");
  stopClick = minim.loadFile("boop.wav");
}
