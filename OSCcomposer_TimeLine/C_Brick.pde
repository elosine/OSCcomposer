BrickSet bricks = new BrickSet(); 

class Brick extends GuiElement {
  //Constructor 1
  Brick(int aix, int ax, int ay, int aw, int ah) {
    super(aix, ax, ay, aw, ah);
  }
  //Constructor 2
  Brick(int aix, int ax, int ay, int aw, int ah, String abdrclr, String afillclr, String ahighlightclr, String aclkclr) {
    super(aix, ax, ay, aw, ah, abdrclr, afillclr, ahighlightclr, aclkclr);
  }
  //Constructor 3
  Brick(int aix, int ax, int ay, int aw, int ah, String abdrclr, String afillclr, 
  String ahighlightclr, String aclkclr, int aguiactiontype) {
    super(aix, ax, ay, aw, ah, abdrclr, afillclr, ahighlightclr, aclkclr, aguiactiontype);
  }

  //Constructor 4 - Load from Preset
  Brick(int aix, int ax, int ay, int aw, int ah, String afillclr, String alabel, String adesc, String aonmsgsStr, String aoffmsgsStr) {
    super( aix, ax, ay, aw, ah, afillclr, alabel, adesc, aonmsgsStr, aoffmsgsStr);
  }



  void drw() {

    super.fillstroke();
    super.msovr();

    //DRAW BRICK
    rectMode(CORNER);
    ellipseMode(CORNER);
    if (curbdrclr.equals("none")) noStroke();
    else { 
      stroke(clr.get(curbdrclr));
      strokeWeight(curbdrwt);
    }
    if (curfillclr.equals("none")) noFill();
    else fill(clr.get(curfillclr));

    rect(l, t, w, h);
    //rect over to denote status

    if (msover) super.highlight();
    if (active) super.highlight();

    rect(l, t, w, h);
    super.wake();
    rect(l+5, t+5, w-10, h-10);
    textFont(monaco10);
    rectMode(CORNER);
    textAlign(LEFT, TOP);
    textLeading(10);
    fill(0);
   // text(str(ix) + ": " + label, l+5, t+5, w-10, h-10); //display index number and label
    text(label, l+5, t+5, w-10, h-10); //display label
   

    if (active) super.resizesqr();
  }

  void msclk() {
    if (msover) active = true;
    else {
      active = false;
    }
    if (active) {
      guiframe.gui.get(Textfield.class, "ONmsg").setText(onmsgsStr);
      guiframe.gui.get(Textfield.class, "label").setText(label);
      guiframe.gui.get(Textfield.class, "offmsg").setText(offmsgsStr);
      guiframe.gui.get(Textfield.class, "desc").setText(desc);
    }
  }

  void msmvd() {
    if (msover) { 
      guiframe.gui.get(Textfield.class, "ONmsg").setText(onmsgsStr);
      guiframe.gui.get(Textfield.class, "label").setText(label);
      guiframe.gui.get(Textfield.class, "offmsg").setText(offmsgsStr);
      guiframe.gui.get(Textfield.class, "desc").setText(desc);
    }
  }

  void keyprs() {
    super.keyprs();
  }

  void msdrg() {
    if (active) {
      super.move();
      super.resiz(0);
    }
  }




  //
} //End Brick Class


//// CLASS SET CLASS ////
class BrickSet {
  ArrayList<Brick> cset = new ArrayList<Brick>();

  // Make Instance Method //
  void mk(int x, int y, int w, int h) {
    cset.add( new Brick(brickct, x, y, w, h) );
    brickct++;
  } //end mk method

  // Make w/ Colors Instance Method //
  void mkclr(int x, int y, int w, int h, String bdrclr, String fillclr, String highlightclr, String clkclr) {
    cset.add( new Brick(brickct, x, y, w, h, bdrclr, fillclr, highlightclr, clkclr) );
    brickct++;
  } //end mkclr method

  // Make w/ Colors Instance Method //
  void mkact(int x, int y, int w, int h, String bdrclr, String fillclr, 
  String highlightclr, String clkclr, int guiactiontype) {
    cset.add( new Brick(brickct, x, y, w, h, bdrclr, fillclr, highlightclr, clkclr, guiactiontype) );
    brickct++;
  } //end mkclr method

  // Make From Preset/Score //
  void mkscore( int ax, int ay, int aw, int ah, String afillclr, String alabel, String adesc, String aonmsg, String aoffmsg) {
    cset.add( new Brick(brickct, ax, ay, aw, ah, afillclr, alabel, adesc, aonmsg, aoffmsg) );
    brickct++;
  } //end mkscore method

  // Draw Set Method //
  void dr() {
    for (int i=cset.size ()-1; i>=0; i--) {
      Brick inst = cset.get(i);
      inst.drw();
      //CURSOR CURVE FOLLOWING
      //Are there any cursors yet?
      if (csrs.clst.size()!=0) {
        //for loop for cursor set
        for (int j=csrs.clst.size ()-1; j>=0; j--) {
          Csr instcsr = csrs.clst.get(j);   
          //Is the cursor touching a curve
          if (instcsr.x >= inst.l && instcsr.x <= inst.r && 
            instcsr.y1 <= inst.t && instcsr.y2 >= inst.b ) {
            //trigger on when cursor hits curve
            if (!inst.on) {
              inst.on = true;
              inst.onaction();
              //  println(inst.clrnum);
            }
            //Normalized curve height data
            //  float normcrvH = norm( inst.ypos(instcsr.x, 0), instcsr.y2, instcsr.y1);
            // println(normcrvH);
          }
          //trigger off when cursor leaves curve
          else {
            //trigger off when cursor leaves curve
            if (inst.on) {
              inst.on = false;
              inst.offaction();
              // println(inst.clrnum);
              //  println(inst.clrname);
            }
          }
        }
      }
    }
  } //end dr method

  // Mouse Pressed Set Method //
  void msclk() {
    for (int i=cset.size ()-1; i>=0; i--) {
      Brick inst = cset.get(i);
      inst.msclk();
    }
  } //end msclk method

  // Mouse Pressed Set Method //
  void msdrg() {
    for (int i=cset.size ()-1; i>=0; i--) {
      Brick inst = cset.get(i);
      inst.msdrg();
    }
  } //end msclk method

  // Mouse Moved Set Method //
  void msmvd() {
    for (int i=cset.size ()-1; i>=0; i--) {
      Brick inst = cset.get(i);
      inst.msmvd();
    }
  } //end msmvd method

    // Key Pressed //
  void keyprs() {
    for (int i=cset.size ()-1; i>=0; i--) {
      Brick inst = cset.get(i);
      inst.keyprs();
    }
  } //end msmvd method

  // Remove Instance Method //
  void rmv(int ix) {
    for (int i=cset.size ()-1; i>=0; i--) {
      Brick inst = cset.get(i);
      if (inst.ix == ix) {
        cset.remove(i);
        break;
      }
    }
  } //End rmv method
} //end class set class

