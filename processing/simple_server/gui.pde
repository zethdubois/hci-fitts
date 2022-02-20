
class Sandbox {
  
  private String name;
  
  int val, xS, yS, xC, yC, ppi, bWset, xlate;
  int[] t; //target cornenrs 
  String mode,server;
  int[] bW; 
  
  Sandbox(StringDict dict){
    val = int(dict.get("screen"));
    //int newarr[] = new int[n + 1];
    int bW[] = new int[4];
    if (val == 0){
      xS = displayWidth;
      yS = displayHeight;
    } else {
      xS = val;
      yS = val;
    }
    if (dict.get("mode") == "local"){
      server = "127.0.0.1";
    }else{
      server = dict.get("server");
    }
    
    xC = xS / 2;
    yC = yS / 2;
    for(int i=1;i<=4;i++){  
      String buff = "w"+i;
      bW[i-1] = int(dict.get(buff));
    }
    println("button sizes: ", Arrays.toString(bW));
    bWset = int(dict.get("bWset"));
    xlate = int(dict.get("xlate"));    
  }
  
  @Override //this is supposed to help change the object to string println, but I coudln't get it to work
  public String toString() {
    return name;
  }
  
}

class Butt {
  
}

class Timer {
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
