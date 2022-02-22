// 2B: Shared drawing canvas (Client)

import processing.net.*;
import controlP5.*;
import ddf.minim.*;

ControlP5 cp5;
Minim minim;
AudioPlayer player;

Client c;
String input;
int data[];

int w = 100;
int h = 100;

void setup() {
  //fullScreen(2);
  size(600, 600);
  background(204);
  stroke(0);
  frameRate(5); // Slow it down a little
  minim = new Minim(this);
  cp5 = new ControlP5(this);   
  player = minim.loadFile("click2.mp3");  
  // Connect to the server’s IP address and port­

  int cX = width / 2;
  int cY = height / 2;
  
  cp5.addBang("target")
     .setPosition(cX-w, cY-h)
     .setSize(w, h)
     //.setTriggerEvent(Bang.RELEASE)
     .setLabel("RETURN")
     .updateSize()
     ;  
  c = new Client(this, "127.0.0.1", 12345); // Replace with your server’s IP and port
  //c = new Client(this, "172.27.148.167", 12345); // Replace with your server’s IP and port
}

void draw() {
  //if (mousePressed == true) {
  //  // Draw our line
  //  stroke(255);
  //  line(pmouseX, pmouseY, mouseX, mouseY);
  //  // Send mouse coords to other person
  //  c.write(pmouseX + " " + pmouseY + " " + mouseX + " " + mouseY + "\n");
  //}


  // Receive data from server
  if (c.available() > 0) {
    resize();
    input = c.readString();
    //input = input.substring(0,input.indexOf("\n"));  // Only up to the newline
    //data = int(split(input, ' '));  // Split values into an array
    //line(data[0], data[1], data[2], data[3]);
    println(input);
  }
  
}

public void resize(){
  w = w+10;
  cp5.getController("target").setSize(w,h);  
}
public void controlEvent(ControlEvent theEvent) {
  String name = theEvent.getController().getName();
  if (name.equals("target")) {
    player.play();
    player.rewind();
    c.write(5);
  }
}
