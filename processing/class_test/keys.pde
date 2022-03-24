
void checkValid(){
  println("-->checkValid()---nothing here yet");
}


void keyPressed() {
  println("key", key, int(key));

  int k = int(key)-48;
  if (k > 0 && k <= E.TPC) {
    println("View settings for trial", k);
    checkValid();
    viewT(k-1); //: 0 index
    if (activeT == E.TPC - 1) {
      //reviewStr="Exit Configuration [SPACEBAR]";
    }
    //reviewStr="Review Trial "+(es)+" [SPACEBAR]";
  }

  switch(key) {
  case '`':
    println("test function");
    setState();
    break;

  case '\'':
    println("increase spacing"); 
    float delta = 0.1;

    break;
  case '\n':

    break;
  }
}
