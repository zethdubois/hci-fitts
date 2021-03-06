int ppi;
int xC, yC; // center of screen
boolean Msg = false;
int tSize; // text size;
boolean OverBeep, OverBoop;
boolean Dual = false;
float fittsID;
int bW; //: button width pixels
String bSelect = "1";
color ROSE = color(253, 206, 217);
color ROSE_a = color(243, 196, 207, 90);
color LBLUE = color(127, 207, 250);
color LBLUE_a = color(137, 207, 240, 60);
color DBLUE = color(7, 17, 150);
color LEMON = color(255, 244, 79);
color LEMON_a = color(245, 234, 69, 90);

color DGREEN = color(0, 120, 0);
color MGREEN = color(0, 200, 0);
color MRED = color(200, 0, 0);
color MGREEN_a = color(0, 190, 0, 60);
String mode, IP, net;
int screen;
String tText;
boolean Calibrate = true;
boolean Calibrated = false;

int lf; 

void showMode() {
  String mText = conditions[ex_condCnt];
  if (GotData) {
    tText = "SPACE TO STOP TRIAL";
  }

  stroke(0);
  strokeWeight(4);
  if (Trial) stroke(YELLOW);
  if (Setup) stroke(MRED);
  if (!Setup && !Trial) stroke(OFFWHITE);
  noFill();
  rect(2, 2, xS-2, yS-2);
  strokeWeight(1);
  stroke(OFFWHITE);
  textAlign(CENTER);
  text(mText, xC, yS-gutter);
  textAlign(LEFT);
}


//text(("- or _ || = or + "), x, y);
//text(("[ or { || ] or }"), x, y);
void writeMsg() {

  int wW = xS/4-gutter-gutter;
  int wH = lf * 12;
  if (Dual) wH = lf * 14;
  int x = gutter;
  int y = tSize+gutter;

  //: readouts (ro_*) trial settings (ts_*)
  String ro_ppi = "["+box.ppi+"] PPI = "+ppi; //: PPI
  String ts_x = "[" + bSelect + "]"; 
  String ts_bWp = " Button Width (px) = "+bW; //: button Width in pixels
  String ts_1 = "["+box.bW1+"]";
  String ts_2 = "["+box.bW2+"]";
  String ts_3 = "["+box.bW3+"]";
  String ts_4 = "["+box.bW4+"]"; 
  String ts_select = ts_1+ts_2+ts_3+ts_4;


  String ts_fW = "Button Width (in) = "+fittsW; //: Fitts Width
  float ts_x_w = textWidth(ts_x);
  float boxWidth = textWidth(ts_bWp)+gutter*3; // length of longest string

  //color selectColor = MGREEN;
  //if (bSelect.equals("X")) selectColor = midred;

  fittsID = log2(fittsA/fittsW+1);
  if (Calibrate) wH = lf*4;

  fill(ROSE_a);
  noStroke();
  rect(gutter, gutter, boxWidth, wH); //: BG rectangle

  fill(ROSE);
  pushMatrix();
  translate(gutter, gutter);
  textFont(bFont);
  textAlign(CENTER);
  text("CONFIG APPARATUS", boxWidth/2, y-gutter/2);//display the times on the interface
  translate(0, y-gutter/2+lf);
  text("unit: "+es_unit, boxWidth/2, 0);

  textFont(nFont);
  textAlign(RIGHT);  

  translate(boxWidth-gutter*2, 1.25*lf);
  if (Calibrate) {
    text(ro_ppi, 0, y);
  } else {
    if (Dual) text("re[C]alibrate screen", 0, y);
  }

  translate(0, lf*2);
  //fill(selectColor);
  //text(ro_x, 0, y);
  text(ts_bWp, 0, y);
  translate(0, lf);
  text(ts_select, 0, y); //: width select options
  //stroke(midgreen);
  //strokeWeight(2);
  //line(x, y+3, x+ro_x_w, y+3);
  //strokeWeight(1);
  //fill(0);
  translate(0, lf);
  //String next = 
  text(("Spacing = "+String.valueOf(int(round(offset*100, 0))+"%")), 0, y);

  // -- trial scores
  popMatrix();
  pushMatrix();

  fill(LBLUE_a);
  translate(boxWidth+gutter*2, 0);
  rect(0, gutter, boxWidth, lf*7);
  textAlign(CENTER);
  textFont(bFont);
  fill(LBLUE);
  text("TRIAL # "+ ex_trialCnt, boxWidth/2, gutter*2);

  textFont(nFont);


  textAlign(LEFT);
  translate(0, lf);  
  text(ts_fW, x, y);  
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
  text(("Index of D = "+ fittsID), x, y);
  textAlign(CENTER);
  translate(0,lf);
  text(("< MacKenzie scores >"), boxWidth/2, y);
  popMatrix();

  //---------------- trial box
  boxWidth = textWidth(ts_bWp)+gutter*3; // length of longest string in trial section  
  fill(LEMON_a);
  noStroke();
  rect(xS-boxWidth-gutter, gutter, xS-gutter, wH); //: BG rectangle 
  //rect(100,400,20,20);
  fill(LEMON);

  pushMatrix();
  translate(xS-boxWidth-gutter, gutter);
  textFont(bFont);
  textAlign(CENTER);
  text("TRIAL SETTINGS", boxWidth/2, y-gutter/2);//display the times on the interface
  translate(gutter, lf*1.5);
  textFont(nFont);
  textAlign(LEFT);  

  translate(0, lf);
  if (participant.equals("anon")) {
    fill(RED);
  } else {
    fill(LEMON);
  }

  text("Participant: "+participant, 0, 0);//display the times on the interface
  fill(LEMON);
  translate(0, lf);  
  text("Condition 1: "+es_condition1, 0, 0);//display the times on the interface
  translate(0, lf);
  text("Condition 2: "+es_condition2, 0, 0);//display the times on the interface
  translate(0, lf);  
  text("Condition 3: "+es_condition3, 0, 0);//display the times on the interface
  translate(0, lf);  
  text("Trials per condtion: "+es_numTPC, 0, 0);//display the times on the interface
  translate(0, lf);    
  text("Samples per trial: "+es_numSPT, 0, 0);//display the times on the interface


  popMatrix();

  //---------------- system messages
  int col = xS/3;
  int col2X = xS/3;
  int col3X = xS/3*x;
  int minCol = 300;
  //if (col3X < minCol*2) col3X = minCol*2;
  //if (col2X < minCol) col2X = minCol;

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
    translate(col-gutter*2, 0);
    fill(RED);
    text(Sip_msg, x, y);
  }

  if (mode.equals("server")) {
    translate(col-gutter*2, 0);
    fill(MGREEN);
    text(Cip_msg, x, y);

    fill(LBLUE);
    translate(0, lf);
    text(ping_msg, x, y);
  }
  if (mode.equals("client")) {
    fill(LBLUE);    
    translate(0, lf);
    text(ping_msg, x, y);

    translate(col-gutter*2, -lf);
    fill(MGREEN);
    text(Cip_msg, x, y);
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
      yS = val/2;
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
