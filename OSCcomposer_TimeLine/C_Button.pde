ButtonSet setObuttons = new ButtonSet(); 

class Button extends GuiElement {
  //Constructor 1
  Button(int aix, int ax, int ay, int aw, int ah) {
    super(aix, ax, ay, aw, ah);
  }
  //Constructor 2
  Button(int aix, int ax, int ay, int aw, int ah, String abdrclr, String afillclr, String ahighlightclr, String aclkclr) {
    super(aix, ax, ay, aw, ah, abdrclr, afillclr, ahighlightclr, aclkclr);
  }
  //Constructor 3
  Button(int aix, int ax, int ay, int aw, int ah, String abdrclr, String afillclr,
  String ahighlightclr, String aclkclr, int aguiactiontype) {
    super(aix, ax, ay, aw, ah, abdrclr, afillclr, ahighlightclr, aclkclr, aguiactiontype);
  }

  void drw() {
    super.fillstroke();
    super.msovr();
    if (msover) super.highlight();
    flash(4, 0.2);
    ellipse(l, t, w, h);
  }

  void msclk() {
    if (msover) {
      //for flash
      now = millis();
      flashon = true;
      guiactions.mk(guiactiontype);
    }
  }
  
  //
} //End Button Class


  //// CLASS SET CLASS ////
  class ButtonSet {
    ArrayList<Button> cset = new ArrayList<Button>();

    // Make Instance Method //
    void mk(int ix, int x, int y, int w, int h) {
      cset.add( new Button(ix, x, y, w, h) );
    } //end mk method

    // Make w/ Colors Instance Method //
    void mkclr(int ix, int x, int y, int w, int h, String bdrclr, String fillclr, String highlightclr, String clkclr) {
      cset.add( new Button(ix, x, y, w, h, bdrclr, fillclr, highlightclr, clkclr) );
    } //end mkclr method

    // Make w/ Colors Instance Method //
    void mkact(int ix, int x, int y, int w, int h, String bdrclr, String fillclr,
    String highlightclr, String clkclr, int guiactiontype) {
      cset.add( new Button(ix, x, y, w, h, bdrclr, fillclr, highlightclr, clkclr, guiactiontype) );
    } //end mkclr method

    // Draw Set Method //
    void dr() {
      for (int i=cset.size ()-1; i>=0; i--) {
        Button inst = cset.get(i);
        inst.drw();
      }
    } //end dr method

    // Mouse Pressed Set Method //
    void msclk() {
      for (int i=cset.size ()-1; i>=0; i--) {
        Button inst = cset.get(i);
        inst.msclk();
      }
    } //end msclk method

      // Remove Instance Method //
    void rmv(int ix) {
      for (int i=cset.size ()-1; i>=0; i--) {
        Button inst = cset.get(i);
        if (inst.ix == ix) {
          cset.remove(i);
          break;
        }
      }
    } //End rmv method
  } //end class set class


