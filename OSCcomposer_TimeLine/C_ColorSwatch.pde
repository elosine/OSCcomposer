class ColorSwatch {
  int x, y, numperrow, sz;

  int[] l, t, r, b;
  int bl, bt, br, bb;
  String msovrname = "niente";
  int msovernum = 0;

  ColorSwatch(int ax, int ay, int anumperrow, int asz) {
    x = ax;
    y = ay;
    numperrow = anumperrow;
    sz = asz;
    l = new int[clr.clrs.size()];
    t = new int[clr.clrs.size()];
    r = new int[clr.clrs.size()];
    b = new int[clr.clrs.size()];
    for (int i=0; i<clr.clrs.size(); i++) {
      l[i] = x+((i*sz)%(sz*numperrow));
      t[i] = y+(floor(i*(1.0/numperrow))*sz);
      r[i] = l[i]+sz;
      b[i] = t[i]+sz;
    }
    bl = x;
    bt = y;
    br = x+(numperrow*sz);
    bb = y + (ceil( (clr.clrs.size()/numperrow))+1)*sz;
  } //End Constructor

  void dr() {
    ////Draw Color blocks
    for (int i=0; i<clr.clrs.size(); i++) {
      fill(clr.get(clr.clrs.keyArray()[i]));
      // rect( x+((i*sz)%(sz*numperrow)), y+(floor(i*(1.0/numperrow))*sz), sz, sz);
      noStroke();
      rectMode(CORNER);
      rect(l[i], t[i], sz, sz);
      /// get name of color from block moused over
      if (mouseOver(l[i], t[i], r[i], b[i])) {
        msovrname = clr.clrs.keyArray()[i];
        msovernum = i;
      }
    }
    //println(msovrname);
  } //End dr method
} //End Class

