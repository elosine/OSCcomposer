class GuiElement {
  // CONSTRUCTOR VARIALBES //
  int ix, x, y, w, h;

  // CLASS VARIABLES //
  int bbBdrWt = 3;
  int bdrwt = 0;
  int bbinset;

  int l, r, t, b, m, c;
  int rx, ry, rw, rh;

  String bdrclr = "orange";
  String fillclr = "indigo";
  String bbbdrclr = "orange";
  String bbfillclr = "sunshine";
  String highlightclr = "mint";
  String clkclr = "green";
  String flashclr = "pink";

  String curbdrclr = "orange";
  int curbdrwt = 0;
  String curfillclr = "indigo";

  boolean active = false;
  boolean resize = false;
  boolean bbactive = false;
  boolean highlightactive = false;
  boolean chgbdrclr = false;
  boolean chgfillclr = false;
  boolean chgtxtclr = false;
  boolean chghighlightclr = false;
  boolean clicked = false;
  boolean clickedoff = false;
  boolean flashon = false;
  int awake = 0;
  String label = "";
  String desc = "";

  boolean msover = false;

  boolean on = false;

  int now = 0;

  int guiactiontype = 0;

  String onmsgsStr = ""; 
  String offmsgsStr = "";
  String[] onmsg = new String[0];
  String[] offmsg = new String[0];
  String[] onaddr = new String[0];
  String[] offaddr =  new String[0];


  Object[][] onobjs = new Object[0][];
  Object[][] offobjs = new Object[0][];




  // CONSTRUCTORS //
  GuiElement(int aix, int ax, int ay, int aw, int ah) {
    ix = aix;
    x = ax;
    y = ay;
    w = aw;
    h = ah;

    //BOUNDING BOX COORDINATES
    l = x;
    t = y;
    r = l+w;
    b = t+h;
    m = l + round(w/2.0);
    c = t + round(h/2.0);

    //RECT COORDINATES
    bbinset = ceil(bbBdrWt/2.0);
    rx = x+bbinset;
    ry = y+bbinset;
    rw = w - (bbinset*2);
    rh = h - (bbinset*2);
  } //end constructor 1

  //Constructor 2
  GuiElement(int aix, int ax, int ay, int aw, int ah, String abdrclr, String afillclr, String ahighlightclr, String aclkclr) {
    ix = aix;
    x = ax;
    y = ay;
    w = aw;
    h = ah;
    bdrclr = abdrclr;
    fillclr = afillclr;
    highlightclr = ahighlightclr;
    clkclr = aclkclr;
    curbdrclr = bdrclr;
    curfillclr = fillclr;


    //BOUNDING BOX COORDINATES
    l = x;
    t = y;
    r = l+w;
    b = t+h;
    m = l + round(w/2.0);
    c = t + round(h/2.0);

    //RECT COORDINATES
    bbinset = ceil(bbBdrWt/2.0);
    rx = x+bbinset;
    ry = y+bbinset;
    rw = w - (bbinset*2);
    rh = h - (bbinset*2);
  } //end constructor 2

    //Constructor 3
  GuiElement(int aix, int ax, int ay, int aw, int ah, String abdrclr, String afillclr, 
  String ahighlightclr, String aclkclr, int aguiactiontype) {
    ix = aix;
    x = ax;
    y = ay;
    w = aw;
    h = ah;
    bdrclr = abdrclr;
    fillclr = afillclr;
    highlightclr = ahighlightclr;
    clkclr = aclkclr;
    guiactiontype = aguiactiontype;

    //BOUNDING BOX COORDINATES
    l = x;
    t = y;
    r = l+w;
    b = t+h;
    m = l + round(w/2.0);
    c = t + round(h/2.0);

    //RECT COORDINATES
    bbinset = ceil(bbBdrWt/2.0);
    rx = x+bbinset;
    ry = y+bbinset;
    rw = w - (bbinset*2);
    rh = h - (bbinset*2);
  } //end constructor 3

  //Constructor 4 - Load from preset
  GuiElement(int aix, int ax, int ay, int aw, int ah, String afillclr, String alabel, String adesc, String aonmsgsStr, String aoffmsgsStr) {
    ix = aix;
    x = ax;
    y = ay;
    w = aw;
    h = ah;
    fillclr = afillclr;
    curfillclr = fillclr;
    onmsgsStr = aonmsgsStr;
    offmsgsStr = aoffmsgsStr;


    //BOUNDING BOX COORDINATES
    l = x;
    t = y;
    r = l+w;
    b = t+h;
    m = l + round(w/2.0);
    c = t + round(h/2.0);

    //RECT COORDINATES
    bbinset = ceil(bbBdrWt/2.0);
    rx = x+bbinset;
    ry = y+bbinset;
    rw = w - (bbinset*2);
    rh = h - (bbinset*2);

    awake = 1;
    //MESSAGES & TEXT
    label = alabel;
    desc = adesc;

    mkOscMsgOn();
    mkOscMsgOff();
  } //end constructor 4


  ///////////////////////////////////////////////////////
  //STATES///////////////////////////////////////////////
  ////////////////////////////////////////////////////// 

  //  Mouse Over //
  void msovr() {
    if (mouseOver( l, t, r, b)) msover = true;
    else msover = false;
  } //End msovr

  //  Clicked //
  void clkd() {
    if (msover) {
      if (mousePressed) clicked = true;
    }
  } //End clkd

  // Clicked Off //
  void clkoff() {
    if (!msover) {
      if (mousePressed) clickedoff = true;
    }
  } //End clkoff

  // Key Pressed //
  void keyprs() {
    if (key == 'a') {
      if (active) awake = (awake+1)%2;
    }
  } //End clkoff

  ///////////////////////////////////////////////////////
  //DECORATIONS///////////////////////////////////////////////
  ////////////////////////////////////////////////////// 

  //  BOUNDING BOX //
  void bb() {
    rectMode(CORNER);
    if (bbBdrWt == 0) noStroke();
    else stroke(clr.get(bbbdrclr));
    strokeWeight(bbBdrWt);
    if (bbfillclr.equals("none")) noFill();
    else fill(clr.get(bbfillclr));
    rect(rx, ry, rw, rh);
  }

  void fillstroke() {
    curfillclr = fillclr;
    curbdrclr = bdrclr;
    curbdrwt = bdrwt;
  }


  void highlight() {
    noFill();
    strokeWeight(4);
    stroke(clr.get("yellow"));
  }

  void wake() {
    if (awake==0) {
      fill(clr.getAlpha("slate", 255));
      noStroke();
    } else {
      noFill();
      noStroke();
    }
  }



  void resizesqr() {
    //RESIZE SQUARE
    if (mouseOver( r-15, b-15, r, b)) {
      noStroke();
      fill(128);
      rectMode(CORNER);
      rect(r-15, b-15, 14, 14);
      resize = true;
    } else {
      resize = false;
    }
  }

  ///////////////////////////////////////////////////////
  //ACTIONS///////////////////////////////////////////////
  ////////////////////////////////////////////////////// 
  void move() {
    //MOVE BOX
    if (msover) {
      if (active) {
        if (!resize) {
          //BOUNDING BOX COORDINATES
          x = x + (mouseX - pmouseX);
          y = y + (mouseY - pmouseY);
          l = x;
          t = y;
          r = l+w;
          b = t+h;
          m = l + round(w/2.0);
          c = t + round(h/2.0);
          //RECT COORDINATES
          rx = x+bbinset;
          ry = y+bbinset;
        }
      }
    }
  }

  void resiz(int mode) {
    //RESIZE
    if (resize) {
      //BOUNDING BOX COORDINATES
      w = w + (mouseX - pmouseX);
      h = h + (mouseY - pmouseY);
      if (mode == 1) h = w;
      else h = h + (mouseY - pmouseY);

      r = l+w;
      b = t+h;
      m = l + round(w/2.0);
      c = t + round(h/2.0);

      //RECT COORDINATES
      rw = w - (bbinset*2);
      rh = h - (bbinset*2);
    }
  } //end resiz



  void flash(int numflsh, float dursec) {
    if (flashon) {
      float durmillis = dursec*1000.0;
      float flashoffdur = 90;
      for (int i=0; i<numflsh; i++) {
        if (millis() >= now+(durmillis*i) && millis() < now+durmillis+(durmillis*i)-flashoffdur) {
          fill(clr.get(flashclr));
        }
      }
      if (millis() > now + (durmillis*numflsh)) flashon = false;
    }
  }//end flash


  void mkOscMsgOn() {
    if (!onmsgsStr.equals("")) {
      onmsg = split(onmsgsStr, '$');
      onobjs = new Object[onmsg.length][];
      for (int i=0; i<onmsg.length; i++) {
        String[] onst = split(onmsg[i], ',');
        onaddr = append(onaddr, onst[0]);

        onobjs[i] = new Object[0];
        for (int j=1; j<onst.length; j++) {
          String[] stt = split(onst[j], ':');
          if (stt[0].equals("int") ) onobjs[i] = appendValue(onobjs[i], int(stt[1]) );
          if (stt[0].equals("float") ) onobjs[i] = appendValue(onobjs[i], float(stt[1]) );
          if (stt[0].equals("str") ) onobjs[i] = appendValue(onobjs[i], stt[1] );
        }
      }
    }
    //
    //
    //
  }


  void mkOscMsgOff() {
    if (!offmsgsStr.equals("")) {
      offmsg = split(offmsgsStr, '$');
      offobjs = new Object[offmsg.length][];
      for (int i=0; i<offmsg.length; i++) {
        String[] offst = split(offmsg[i], ',');
        offaddr = append(offaddr, offst[0]);
        offobjs[i] = new Object[0];

        for (int j=1; j<offst.length; j++) {
          String[] stt = split(offst[j], ':');
          if (stt[0].equals("int") ) offobjs[i] = appendValue(offobjs[i], int(stt[1]) );
          if (stt[0].equals("float") ) offobjs[i] = appendValue(offobjs[i], float(stt[1]) );
          if (stt[0].equals("str") ) offobjs[i] = appendValue(offobjs[i], stt[1] );
        }
      }
    }
    //
    //
    //
  }



  void onaction() {
    if (onaddr.length != 0) {
      for (int i=0; i<onaddr.length; i++) {
        meosc.send(onaddr[i], onobjs[i], splscore);
        println(onaddr[i] + "  :  " + onobjs[i]);
      }
    }
  }


  void offaction() {
    if (offaddr.length != 0) {
      for (int i=0; i<offaddr.length; i++) {
        meosc.send(offaddr[i], offobjs[i], splscore);
      }
    }
  }





  //
}  //End class

