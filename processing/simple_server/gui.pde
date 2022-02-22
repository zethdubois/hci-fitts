int ppi;
int xC, yC; // center of screen
boolean Msg = false;
int tSize; // text size;
boolean OverStart, OverStop;



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
  text(("- or _ || = or + "), x, y);
  translate(0, lf);
  text(("PPI = "+ ppi), x, y);
  translate(0, lf);
  text(("[ or { || ] or }"), x, y);
  translate(0, lf);
  text(("Button Width = "+bW + " pixels"), x, y);  
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

class Butt {
}


/*  
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
 
 stopButton.addActionListener(this);
 g.add (stopButton);
 g.add (progress);
 
 //calculate center of screen
 int cX = displayWidth / 2;
 int cY = displayHeight / 2;
 
 stopButton.setLookAndFeel(redLook);
 
 //calculate slider size and position
 float w = wSlideMod * displayWidth;
 float h = w * slideAspect;
 float pX = cX - w/2;
 float pY = displayHeight - h * 2;
 
 float x = displayWidth / 2 - w / 2;
 float y = displayHeight / 2 - h / 2;
 
 startButton = new IFButton ("Start", int(x), int(y), int(w), int(h));  
 g.add (startButton);
 startButton.addActionListener(this);
 
 cp5.addSlider("size")
 .setPosition(int(pX), int(pY))
 .setSize(int(w),int(h))
 .setRange(0,255)
 .setNumberOfTickMarks(5)
 ;
 return new int[] {xS, yS};
 }
 
 */
