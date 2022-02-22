int ppi;
int xC, yC; // center of screen
boolean Msg = false;
int tSize; // text size;
boolean OverStart, OverStop;

  //text(("- or _ || = or + "), x, y);
  //text(("[ or { || ] or }"), x, y);
void writeMsg() {
  int wH = yS/3;
  int wW = xS/4-gutter-gutter;
  int lf = int(tSize * 1.5f);
  int x = gutter;
  int y = tSize+gutter;
  String fW = "Button Width = "+fittsW+" inches";
  float fWw = textWidth(fW); //: length of longest string

  fill(137, 207, 240);
  rect(gutter, gutter, fWw+gutter*4, wH); //: BG rectangle
  fill(0);
  pushMatrix();
  translate(gutter, gutter);
  textFont(bFont);
  textAlign(CENTER);
  text("CONFIG APPARATUS", fWw/2, y-gutter/2);//display the times on the interface
  translate(0, lf);
  textFont(nFont);
  textAlign(LEFT);
  text(("PPI = "+ ppi), x, y);
  translate(0, lf);
  text(("Button Width = "+bW + " pixels"), x, y);
  translate(0, lf);
  text(("Spacing [0-1] = "+offset), x, y); 
  translate(0, lf*2);
  text(("Fitts' scores"), x, y);  
  translate(0, lf);  
  text(fW, x, y);  
  translate(0, lf); 

  text(("Amplitude = "+ fittsA + " inches"), x, y);


  popMatrix();
}

class Sandbox {

  private String name;

  int val, xS, yS, xC, yC, ppi, bW;
  int tSize;
  float offset;
  int[] t; //target cornenrs 
  String mode, server;
  int[] i_bW; 

  Sandbox(StringDict dict) {
    val = int(dict.get("screen"));
    //int newarr[] = new int[n + 1];
    int i_bW[] = new int[4];
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
    for (int i=1; i<=4; i++) {  
      String buff = "w"+i;
      i_bW[i-1] = int(dict.get(buff));
    }
    println("button sizes: ", Arrays.toString(i_bW));
    bW = int(dict.get("button_width"));
    offset = float(dict.get("offset"));
    tSize = int(dict.get("text_size"));
    ppi = int(dict.get("ppi"));
  }

  @Override //this is supposed to help change the object to string println, but I coudln't get it to work
    public String toString() {
    return name;
  }
}
