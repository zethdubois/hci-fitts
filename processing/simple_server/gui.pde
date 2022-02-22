int ppi;
int xC, yC; // center of screen
boolean Msg = false;
int tSize; // text size;
boolean OverStart, OverStop;
float ID;
int bW; //: button width pixels
int bSelect = 1;
color rose = color(243, 196, 207);
color darkgreen = color(0, 120, 0);
color midgreen = color(0, 200, 0);

//text(("- or _ || = or + "), x, y);
//text(("[ or { || ] or }"), x, y);
void writeMsg() {

  int wW = xS/4-gutter-gutter;
  int lf = int(tSize * 1.5f);
  int wH = lf*12;  
  int x = gutter;
  int y = tSize+gutter;

  //: readouts (ro_*)
  String ro_ppi = "["+box.ppi+"] PPI = "+ppi; //: PPI
  String ro_x = "["+bSelect+"]"; 
  String ro_bWp = " Button Width = "+bW+" pixels"; //: button Width in pixels
  String ro_1 = "["+box.bW1+"]";
  String ro_2 = "["+box.bW2+"]";
  String ro_3 = "["+box.bW3+"]";
  String ro_4 = "["+box.bW4+"]"; 
  String ro_select = ro_1+ro_2+ro_3+ro_4;


  String ro_fW = "Button Width = "+fittsW+" inches"; //: Fitts Width
  float ro_x_w = textWidth(ro_x);
  float boxWidth = textWidth(ro_bWp)+gutter*4 + ro_x_w; //: length of longest string


  ID = log2(fittsA/fittsW+1);

  fill(rose);
  rect(gutter, gutter, boxWidth, wH); //: BG rectangle
  fill(0);
  pushMatrix();
  translate(gutter, gutter);
  textFont(bFont);
  textAlign(CENTER);
  text("CONFIG APPARATUS", boxWidth/2, y-gutter/2);//display the times on the interface
  translate(0, lf);
  textFont(nFont);
  textAlign(LEFT);
  text(ro_ppi, x, y);
  translate(0, lf);
  fill(midgreen);
  text(ro_x, x, y);
  fill(0);
  text(ro_bWp, x+ro_x_w, y);
  translate(0, lf);
  text(ro_select, x, y); //: width select options
  //stroke(midgreen);
  //strokeWeight(2);
  //line(x, y+3, x+ro_x_w, y+3);
  //strokeWeight(1);
  //fill(0);
  translate(0, lf);
  text(("Spacing [0-1] = "+offset), x, y); 
  translate(0, lf*2);
  textAlign(CENTER);
  textFont(bFont);
  text(("MacKenzie scores"), boxWidth/2, y);
  textFont(nFont);
  textAlign(LEFT);
  translate(0, lf);  
  text(ro_fW, x, y);  
  translate(0, lf); 
  text(("Amplitude = "+ fittsA + " inches"), x, y);
  translate(0, lf); 
  text(("Index of D = "+ ID), x, y);


  popMatrix();
}

class Sandbox {

  private String name;

  int val, xS, yS, xC, yC, ppi;
  int bW1, bW2, bW3, bW4;
  int tSize;
  float offset;
  //int[] t; //target cornenrs 
  String mode, server;
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
    if (dict.get("mode") == "local") {
      server = "127.0.0.1";
    } else {
      server = dict.get("server");
    }

    xC = xS / 2;
    yC = yS / 2;
    bW1 = int(dict.get("button_width_1"));
    bW2 = int(dict.get("button_width_2"));
    bW3 = int(dict.get("button_width_3"));
    bW4 = int(dict.get("button_width_4"));
    int[] i_bW = new int[] { bW1, bW2, bW3, bW4 };
    //for (int i=1; i<=4; i++) { 
    //  println("hello: "+i);
    //  String buff = "w"+i;
    //  println(dict.get(buff));
    //  i_bW[i-1] = dict.get(buff);
    //}
    println("button sizes: ", Arrays.toString(i_bW));
    //bW1 = int(i_bW[0]);//int(dict.get("button_width"));
    offset = float(dict.get("offset"));
    tSize = int(dict.get("text_size"));
    ppi = int(dict.get("ppi"));
  }

  @Override //this is supposed to help change the object to string println, but I coudln't get it to work
    public String toString() {
    return name;
  }
}
