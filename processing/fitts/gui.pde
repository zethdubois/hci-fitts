/* COLOR PALLETE https://www.color-hex.com/user/add-palette.php?id=1009737 */
int ts_adj = 1;
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
color ROSE_a = color(243, 196, 207, 45);
color TERMINAL = color(127, 207, 250);
color TERMINAL_a = color(137, 207, 240, 60);
color DBLUE = color(7, 17, 150);
color LEMON = color(255, 244, 79);
color LEMON_a = color(245, 234, 69, 90);

//int ROSE = #ffced9;

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
//--CONSTANTS

String FRAME = "FRAME";
String BOLD = "BOLD";
String TITLE = "TITLE";
String NONE = "NONE";

void drawBox(int c, int bX, int bY, int bW, int bH, String title ) {
  pushStyle();
  fill(c, 60);
  noStroke();
  rect(bX, bY, bW, bH); //: BG rectangle
  if (!title.trim().isEmpty()) boxLF(c, 2, CENTER, title, bX+bW/2, bY+tSize-2, 0, 0, TITLE);
  popStyle();
}

//: this proc automates text writting to the UI
void boxLF(int c, int f, int align, String S, int x, int y, int tx, int ty, String mode) {
  //: modes: 0 normal, 1 outline, 2 faux bold
  int tS = tSize + f;
  translate(tx, ty);
  pushStyle();

  textSize(tS);
  textAlign(align);
  if (mode.equals("title")) {
    int o = tS/3;
    float mod = .7f; //: this is a mod to reduce the vertical offset to the top of text
    int bx = int(textWidth(S));
    fill(0);
    if (align == CENTER) {
      rectMode(CENTER);
      rect(x, y-tS*mod/2, bx+o, tS*mod+o);
    }
    mode = "bold"; //: do bold now
  }  
  fill(c);
  text(S, x, y);

  if (mode.equals("bold")) text(S, x+1, y-1); // FAUX BOLD
  if (mode.equals("box")) {                  // box it in
    int o = tS/2;
    float mod = .7f; //: this is a mod to reduce the vertical offset to the top of text
    int bx = int(textWidth(S));
    noFill();
    stroke(c, 127);
    if (align == CENTER) {
      rectMode(CENTER);
      rect(x, y-tS*mod/2+(.1*tS), bx+o, tS*mod+o);
    }
    //rectMode(CORNERS);
  }
  popStyle();
}

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

  //int wW = xS/4-gutter-gutter;
  int wH = lf * 12;
  if (Dual) wH = lf * 14;
  int x = gutter;

  //: readouts (ro_*) trial settings (ts_*)
  String ro_ppi = "["+box.ppi+"] PPI = "+ppi; //: PPI
  String ts_x = "[" + bSelect + "]"; 
  String buff = "Width:";
  ArrayList<String> ts_bWS_I = new ArrayList<String>();
  float val;
  for (int i = 0; i<4; i++) {
    if (Dual) val = ts_bWi_I[i]; 
    else val = ts_bWp_I[i]; 
    ts_bWS_I.add(buff+val);
    //ts_bWpS_I = new String [] {(buff+ts_bWp_I[0]), (buff+ts_bWp_I[1]), (buff+ts_bWp_I[2]), (buff+ts_bWp_I[3])};
  }


  buff = "ID:";
  String [] ts_IDS_I = new String [] {(buff+ts_ID_I[0]), (buff+ts_ID_I[1]), 
    (buff+ts_ID_I[2]), (buff+ts_ID_I[3])};

  String ts_bWp = " Button Width = "+bW; //: button Width in pixels
  String ts_1 = "["+box.bW1+"]";
  String ts_2 = "["+box.bW2+"]";
  String ts_3 = "["+box.bW3+"]";
  String ts_4 = "["+box.bW4+"]"; 
  String ts_select = ts_1+ts_2+ts_3+ts_4;
  String S = "";

  String ts_fW = "Button Width (in) = "+fittsW; //: Fitts Width
  float ts_x_w = textWidth(ts_x);
  int boxWidth = int(textWidth(ts_bWp)+gutter*3); // length of longest string


  if (Calibrate) wH = lf*4;

  //---BOXES-----------------------------------------------------------------
  pushMatrix();
  int xc = boxWidth/2; 
  int kSpace = gutter*3;
  translate(gutter, gutter);
  drawBox(ROSE, 0, 0, boxWidth, wH, "CONFIG APPARATUS"); //: cnfig app box
  translate(gutter*2+boxWidth+kSpace, 0);
  drawBox(TERMINAL, 0, 0, boxWidth, wH, ("TRIAL # "+ ex_trialCnt));
  popMatrix();
  pushMatrix();
  translate(xS-gutter-boxWidth, gutter);
  drawBox(LEMON, 0, 0, boxWidth, wH, "METHODS");
  popMatrix();
  pushMatrix();
  translate(gutter, yS-lf*2-gutter);
  fill(TERMINAL_a);
  drawBox(TERMINAL, 0, 0, xS-gutter*2, 2*lf, "");
  //rect(0, 0, xS-gutter*2, 2*lf); //: BG rectangle
  popMatrix();
  pushMatrix();

  //--LINE 1

  if (iMode == 0) S = "Control Mode: SINGLE"; 
  else S = "Control Mode: DUAL";
  boxLF(ROSE, 0, CENTER, S, xc, 0, gutter, int(lf*2.5), NONE);

  if (iMode == 1) {
    S = "SERVER";
    boxLF(MGREEN, 0, CENTER, S, xc, 0, 0,lf, FRAME);
  }
  if (iMode == 2) {
    S = "CLIENT";
    boxLF(RED, 0, CENTER, S, xc, 0, 0,lf, FRAME);
  }

  //---LINE 2
  
  //println("...........................",ts_bWpS_I[0]);

  boxLF(ROSE, 0, RIGHT, ts_IDS_I[0], 0, 0, boxWidth-gutter, lf*2, NONE);  
  
  boxLF(TERMINAL, 0, LEFT, ts_bWS_I.get(0), 0, 0, gutter*2+kSpace, 0, NONE);  
  //text(ts_bWpS_I[0], 0, 0);
  
  boxLF(ROSE, 0, RIGHT, ts_select, 0, 0, 0, lf, NONE);
  //text(ts_select, 0, 0); //: width select options


  /*
  fill(ROSE);
   translate(0, y-gutter/2+lf);
   text("unit: "+es_unit, boxWidth/2, 0);
   */

  //---- credit card
  textFont(nFont);
  textAlign(RIGHT);  

  translate(boxWidth-gutter*2, 1.25*lf);
  if (Calibrate) {
    text(ro_ppi, 0, 0);
  } else {
    if (Dual) text("re[C]alibrate screen", 0, lf);
  }


  //text(ro_x, 0, y);

  //stroke(midgreen);
  //strokeWeight(2);
  //line(x, y+3, x+ro_x_w, y+3);
  //strokeWeight(1);
  //fill(0);
  translate(0, lf);
  //String next = 
  text(("Spacing = "+String.valueOf(int(round(offset*100, 0))+"%")), 0, 0);

  /*
  // -- trial scores
   popMatrix();
   pushMatrix();
   
   
   //-----bump text size +2
   fill(TERMINAL);
   text("TRIAL # "+ ex_trialCnt, boxWidth/2, gutter*2);
   
   textFont(nFont);
   
   
   textAlign(LEFT);
   translate(0, lf);  
   text(ts_fW, x, 0);  
   translate(0, lf);
   if (Dual) {
   text(("Distance A = "+ a_fittsA + " inches"), x, 0);
   translate(0, lf);
   text(("Distance B = "+ b_fittsA + " inches"), x, 0);
   translate(0, lf);
   fittsA = 0;
   text(("Amplitude = ?"+ fittsA + " inches"), x, 0);
   } else {
   text(("Amplitude = "+ fittsA + " inches"), x, 0);
   }
   translate(0, lf); 
   text(("Index of D = "+ fittsID), x, 0);
   textAlign(CENTER);
   translate(0, lf);
   text(("< MacKenzie scores >"), boxWidth/2, 0);
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
   //!! bumptextsize +2
   textAlign(CENTER);
   text("METHODS", boxWidth/2, 0-gutter/2);//display the times on the interface
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
   
   */
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


  // ...msgs
  fill(TERMINAL);

  translate(0, -gutter);
  pushMatrix(); // 2 deep
  text(mode_msg, x, 0);
  translate(0, lf);
  text(net_msg, x, 0);
  popMatrix(); // 1 deep
  if (Dual) {
    translate(col-gutter*2, 0);
    fill(RED);
    text(Sip_msg, x, 0);
  }

  if (mode.equals("server")) {
    translate(col-gutter*2, 0);
    fill(MGREEN);
    text(Cip_msg, x, 0);

    fill(TERMINAL);
    translate(0, lf);
    text(ping_msg, x, 0);
  }
  if (mode.equals("client")) {
    fill(TERMINAL);    
    translate(0, lf);
    text(ping_msg, x, 0);

    translate(col-gutter*2, -lf);
    fill(MGREEN);
    text(Cip_msg, x, 0);
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
  int[] bW_I; 


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
    int[] bW_I = new int[] { bW1, bW2, bW3, bW4 };

    println("button sizes: ", Arrays.toString(bW_I));
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
