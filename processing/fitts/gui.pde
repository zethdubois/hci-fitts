int ppi;
int xC, yC; // center of screen
boolean Msg = false;
int tSize; // text size;
boolean OverStart, OverStop;
boolean Dual = false;
float ID;
int bW; //: button width pixels
String bSelect = "1";
color ROSE = color(253, 206, 217);
color ROSE_a = color(243, 196, 207, 127);
color LBLUE = color(147, 217, 250);
color LBLUE_a = color(137, 207, 240, 127);

color darkgreen = color(0, 120, 0);
color midgreen = color(0, 200, 0);
color midred = color(200, 0, 0);
String mode, IP, net;
int screen;

int lf; 

//text(("- or _ || = or + "), x, y);
//text(("[ or { || ] or }"), x, y);
void writeMsg() {

  int wW = xS/4-gutter-gutter;
  int wH = lf * 12;
  if (Dual) wH = lf * 14;
  int x = gutter;
  int y = tSize+gutter;

  //: readouts (ro_*)
  String ro_ppi = "["+box.ppi+"] PPI = "+ppi; //: PPI
  String ro_x = "[" + bSelect + "]"; 
  String ro_bWp = " Button Width (px) = "+bW; //: button Width in pixels
  String ro_1 = "["+box.bW1+"]";
  String ro_2 = "["+box.bW2+"]";
  String ro_3 = "["+box.bW3+"]";
  String ro_4 = "["+box.bW4+"]"; 
  String ro_select = ro_1+ro_2+ro_3+ro_4;


  String ro_fW = "Button Width (in) = "+fittsW; //: Fitts Width
  float ro_x_w = textWidth(ro_x);
  float boxWidth = textWidth(ro_bWp)+gutter*3; // + ro_x_w; //: length of longest string

  color selectColor = midgreen;
  if (bSelect.equals("X")) selectColor = midred;

  ID = log2(fittsA/fittsW+1);

  fill(ROSE_a);
  noStroke();
  rect(gutter, gutter, boxWidth, wH); //: BG rectangle

  fill(ROSE);
  pushMatrix();
  translate(gutter, gutter);
  textFont(bFont);
  textAlign(CENTER);
  text("CONFIG APPARATUS", boxWidth/2, y-gutter/2);//display the times on the interface

  textFont(nFont);
  textAlign(RIGHT);  
  popMatrix();
  pushMatrix();
  translate(boxWidth-gutter, 1.5*lf);

  text(ro_ppi, 0, y);
  translate(0, lf);
  //fill(selectColor);
  //text(ro_x, 0, y);
  text(ro_bWp, 0, y);
  translate(0, lf);
  text(ro_select, 0, y); //: width select options
  //stroke(midgreen);
  //strokeWeight(2);
  //line(x, y+3, x+ro_x_w, y+3);
  //strokeWeight(1);
  //fill(0);
  translate(0, lf);
  text(("Spacing = "+offset), 0, y); 
  translate(0, lf*2);
  textAlign(CENTER);
  textFont(bFont);
  text(("MacKenzie scores"), -boxWidth/2+2*gutter, y);
  textFont(nFont);
  textAlign(RIGHT);
  translate(-gutter, lf);  
  text(ro_fW, x, y);  
  translate(0, lf);
  if (Dual) {
    text(("Distance A = "+ a_fittsA + " inches"), x, y);
    translate(0, lf);
    text(("Distance B = "+ b_fittsA + " inches"), x, y);
    translate(0, lf);
    fittsA = 0;
    text(("Amplitude = ?"+ fittsA + " inches"), x, y);
  } else {
    text(("Amplitude = "+ fittsA + " inches"), x, y);
  }
  translate(0, lf); 
  text(("Index of D = "+ ID), x, y);
  popMatrix();

  //---------------- system messages
  int col2X = xS/3*2;
  int col3X = xS/3;
  int minCol = 300;
  if (col2X < minCol*2) col2X = minCol*2;
  if (col2X < minCol) col2X = minCol;

  textAlign(LEFT);
  String mode_msg = "Mode: " + mode;
  String net_msg = " Net: " + effective_net;

  String Sip_msg = "Server IP: " + SERVER_IP ;
  String Cip_msg = "Client IP: " + CLIENT_IP;
  String ping_msg = "Ping time: " + netPing;
  String connect_msg = "";

 

  // -- box
  pushMatrix();
  translate(gutter, yS-lf*2-gutter);
  fill(LBLUE_a);
  rect(0, 0, xS-gutter*2, 2*lf); //: BG rectangle

  // ...msgs
  fill(LBLUE);

  translate(0, -gutter);
  pushMatrix(); // 2 deep
  text(mode_msg, x, y);
  translate(0, lf);
  text(net_msg, x, y);
  popMatrix(); // 1 deep
  if (Dual) {
    translate(col2X-gutter*2, 0);
    text(Sip_msg, x, y);
    translate(0, lf);
    text(ping_msg, x, y);
  }

  // -- reset stuff
  fill(0);
  popMatrix();
}

class Sandbox {

  private String name;

  int val, xS, yS, xC, yC, ppi, screen;
  int bW1, bW2, bW3, bW4;
  int tSize;
  float offset;
  //int[] t; //target cornenrs 
  String mode, server, network;
  int[] i_bW; 


  Sandbox(StringDict dict) {
    val = int(dict.get("screen"));
    //int newarr[] = new int[n + 1];

    if (val == 0) {
      xS = displayWidth;
      yS = displayHeight;
    } else {
      xS = val;
      yS = val;
    }
    if (dict.get("net") == "local") {
      IP = "127.0.0.1";
      server = "127.0.0.1";
    } else {
      IP = dict.get("server");
    }
    mode = dict.get("mode");
    xC = xS / 2;
    yC = yS / 2;
    bW1 = int(dict.get("button_width_1"));
    bW2 = int(dict.get("button_width_2"));
    bW3 = int(dict.get("button_width_3"));
    bW4 = int(dict.get("button_width_4"));
    int[] i_bW = new int[] { bW1, bW2, bW3, bW4 };

    println("button sizes: ", Arrays.toString(i_bW));
    offset = float(dict.get("offset"));
    tSize = int(dict.get("text_size"));
    ppi = int(dict.get("ppi"));
    network = dict.get("network");
    screen = int(dict.get("screen"));
  }

  @Override //this is supposed to help change the object to string println, but I coudln't get it to work
    public String toString() {
    return name;
  }
}
