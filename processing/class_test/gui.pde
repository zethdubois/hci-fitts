

void uiStrings(){
}

void uiApparatus(){
  pushMatrix();
  popMatrix();
}


void drawBox(int c, int bX, int bY, int bW, int bH, String title ) {
  pushStyle();
  fill(c, 40);
  noStroke();
  rect(bX, bY, bW, bH); //: BG rectangle
  if (!title.trim().isEmpty()) textLF(c, 2, CENTER, title, bX+bW/2, bY+E.TS-2, 0, 0, TITLE);
  popStyle();
}


//: this proc automates text writting to the UI
void textLF(int c, int f, int align, String S, int x, int y, int tx, int ty, String mode) {
  //: modes: 0 normal, 1 outline, 2 faux bold
  int tS = E.TS + f;
  translate(tx, ty);
  pushStyle();

  textSize(tS);
  textAlign(align);
  if (mode.equals("TITLE")) {
    int o = tS/3;
    float mod = .7f; //: this is a mod to reduce the vertical offset to the top of text
    int bx = int(textWidth(S));
    fill(0);
    if (align == CENTER) {
      rectMode(CENTER);
      rect(x, y-tS*mod/2, bx+o, tS*mod+o);
    }
    mode = "BOLD"; //: do bold now
  }  
  fill(c);
  text(S, x, y);

  if (mode.equals("BOLD")) text(S, x+1, y-1); // FAUX BOLD
  if (mode.equals("BOX")) {                  // box it in
    int o = tS/2;
    float mod = .7f; //: this is a mod to reduce the vertical offset to the top of text
    int bx = int(textWidth(S));
    noFill();
    stroke(c, 127);
    if (align == CENTER) {
      rectMode(CENTER);
      rect(x, y-tS*mod/2+(.1*tS), bx+o, tS*mod+o);
    }
  }
  popStyle();
}
