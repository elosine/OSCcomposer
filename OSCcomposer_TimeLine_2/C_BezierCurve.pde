//USE CURVE STROKE WEIGHT TO CONTROL ANOTHER FACTOR USUALLY AMPLITUDE

class BezierCurve {
  // Constructor Variables //
  int ix;
  String clrname;
  color crvclr;
  int clrnum;
  int anchorpt1x, anchorpt1y, ctlpt1x, ctlpt1y, ctlpt2x, ctlpt2y, anchorpt2x, anchorpt2y, ctlpt1xr, ctlpt1yr, ctlpt2xr, ctlpt2yr;
  String oscadr;

  // Class Variables //
  PVector A, B, C, D;
  float[]x = new float[4];
  float[]y = new float[4];
  int crvStrkWt = 2;
  float l, t, r, bm;
  color bbclr;
  boolean active = false;
  int aptsz = 32;
  int ctptsz = 24;
  String label = "";
  String desc = "";
  boolean msover = false;
  boolean tbactive = false;

  //// CURVE FOLLOWING VARIABLES ////
  float SMALL = 0.0000000001;
  int b;
  float [] OPL = new float[32];
  float yLookup;
  PVector xy;
  int crvflsz = 13;

  boolean on = false;

  // Constructor //
  BezierCurve(int aix, String aclrname, int aanchorpt1x, int aanchorpt1y, int actlpt1xr, 
  int actlpt1yr, int actlpt2xr, int actlpt2yr, int aanchorpt2x, int aanchorpt2y, 
  String aoscadr) {
    clrname = aclrname;
    ix = aix;
    crvclr = clr.get(clrname);

    anchorpt1x = aanchorpt1x;
    anchorpt1y = aanchorpt1y;
    ctlpt1xr = actlpt1xr;
    ctlpt1yr = actlpt1yr;
    ctlpt2xr = actlpt2xr;
    ctlpt2yr = actlpt2yr;
    anchorpt2x = aanchorpt2x;
    anchorpt2y = aanchorpt2y;

    oscadr = aoscadr;

    //Calculate Control Points relative to Anchor Points
    ctlpt1x = anchorpt1x + ctlpt1xr;
    ctlpt1y = anchorpt1y + ctlpt1yr;
    ctlpt2x = anchorpt2x + ctlpt2xr;
    ctlpt2y = anchorpt2y + ctlpt2yr;

    A = new PVector(anchorpt1x, anchorpt1y);
    B = new PVector(ctlpt1x, ctlpt1y);
    C = new PVector(ctlpt2x, ctlpt2y);
    D = new PVector(anchorpt2x, anchorpt2y);


    x[0] = A.x;
    x[1] = B.x;
    x[2] = C.x;
    x[3] = D.x;
    y[0] = A.y;
    y[1] = B.y;
    y[2] = C.y;
    y[3] = D.y;
  } //End Constructor

  void drw() {
    msovr();
    // Update Curve Bounding Box //
    if (x[0]<x[3]) {
      l = x[0];
      r = x[3];
    } else {
      l = x[3];
      r = x[0];
    } 
    if (y[0]<y[3]) {
      t = y[0];
      bm = y[3];
    } else {
      t = y[3];
      bm = y[0];
    }

    // Draw blue bounding box when moused over //
    // And if clicked make curve active //
    if (!active) {
      if (mouseOver(l, t, r, bm)) {
        if (!mousePressed) {
          stroke(clr.getAlpha("dodgerblue", 80));
        } 
        //
        else {
          active = true;
        }
        rectMode(CORNER);
        noFill();
        rect(l, t, r-l, bm-t); 
        textSize(24);
        fill(clr.get("orange"));
        text(ix, l, t);
      }
    }
    // if active, make bb red, draw anchor and control points //
    if (active) {
      stroke(clr.getAlpha("red", 80));
      rectMode(CORNER);
      noFill();
      rect(l, t, r-l, bm-t);
      ///Anchor 1
      ellipseMode(CENTER);
      fill(clr.getAlpha("dodgerblue", 80));
      noStroke();
      ellipse(x[0], y[0], aptsz, aptsz);
      ///Anchor 2
      ellipse(x[3], y[3], aptsz, aptsz);
      ///Control 1
      rectMode(CENTER);
      fill(clr.getAlpha("goldenrod", 150));
      rect(x[1], y[1], ctptsz, ctptsz);
      ///Control 2
      rect(x[2], y[2], ctptsz, ctptsz);
      ///Connecting lines 
      strokeWeight(1);
      stroke(clr.getAlpha("grey", 100));
      line(x[0], y[0], x[1], y[1]);
      line(x[3], y[3], x[2], y[2]);
      ////Index Number Displayed
      textSize(24);
      fill(clr.get("orange"));
      text(ix, l, t);
    }
    // Deactivate when clicked off //
    if (active) {
      //if mouse is outside of bounding box but not touching any of the anchor/ctrl points
      //// in case control points are outside of bounding box
      if (!mouseOver(l-aptsz-20, t-aptsz-20, r+aptsz+20, bm+aptsz+20) &&
        !mouseOver(x[0]-aptsz, y[0]-aptsz, x[0]+aptsz, y[0]+aptsz) &&
        !mouseOver(x[3]-aptsz, y[3]-aptsz, x[3]+aptsz, y[3]+aptsz) &&
        ! mouseOver(x[1]-ctptsz, y[1]-ctptsz, x[1]+ctptsz, y[1]+ctptsz) &&
        !mouseOver(x[2]-ctptsz, y[2]-ctptsz, x[2]+ctptsz, y[2]+ctptsz)
        ) {
        if (mousePressed) {
          active = false;
        }
      }
    }
    // If Active, enable moving curve and points - see msdrg method


    // Draw Curve //
    strokeWeight(crvStrkWt);
    stroke(clr.get(clrname));
    noFill();
    bezier(x[0], y[0], x[1], y[1], x[2], y[2], x[3], y[3]);
  } //End drw

  void msdrg() {  
    // If Active, enable moving
    if (active) {
      //If mouse is over the bounding box but not over any of the ctrl/anchor points
      if (!mouseOver(x[0]-(aptsz/2), y[0]-(aptsz/2), x[0]+(aptsz/2), y[0]+(aptsz/2)) &&
        !mouseOver(x[3]-(aptsz/2), y[3]-(aptsz/2), x[3]+(aptsz/2), y[3]+(aptsz/2)) &&
        !mouseOver(x[1]-(ctptsz/2), y[1]-(ctptsz/2), x[1]+(ctptsz/2), y[1]+(ctptsz/2)) &&
        !mouseOver(x[2]-(ctptsz/2), y[2]-(ctptsz/2), x[2]+(ctptsz/2), y[2]+(ctptsz/2)) &&
        mouseOver(l, t, r, bm)) {
        for (int i=0; i<4; i++) {
          x[i] = x[i]+mouseX-pmouseX;
          y[i] = y[i]+mouseY-pmouseY;
        }
      }
      /// Move Anchor 1 if not over control 1
      if (mouseOver(x[0]-(aptsz/2), y[0]-(aptsz/2), x[0]+(aptsz/2), y[0]+(aptsz/2)) &&
        !mouseOver(x[1]-(ctptsz/2), y[1]-(ctptsz/2), x[1]+(ctptsz/2), y[1]+(ctptsz/2))) {
        x[0] = x[0]+mouseX-pmouseX;
        y[0] = y[0]+mouseY-pmouseY;
        x[1] = x[1]+mouseX-pmouseX;
        y[1] = y[1]+mouseY-pmouseY;
      }
      /// Move Anchor 2 if not over control 2
      if (mouseOver(x[3]-(aptsz/2), y[3]-(aptsz/2), x[3]+(aptsz/2), y[3]+(aptsz/2)) &&
        !mouseOver(x[2]-(ctptsz/2), y[2]-(ctptsz/2), x[2]+(ctptsz/2), y[2]+(ctptsz/2))) {
        x[3] = x[3]+mouseX-pmouseX;
        y[3] = y[3]+mouseY-pmouseY;
        x[2] = x[2]+mouseX-pmouseX;
        y[2] = y[2]+mouseY-pmouseY;
      }
      /// Move Ctrl 1
      if (mouseOver(x[1]-(ctptsz/2), y[1]-(ctptsz/2), x[1]+(ctptsz/2), y[1]+(ctptsz/2))) {
        x[1] = x[1]+mouseX-pmouseX;
        y[1] = y[1]+mouseY-pmouseY;
      }
      /// Move Ctrl 2
      if (mouseOver(x[2]-(ctptsz/2), y[2]-(ctptsz/2), x[2]+(ctptsz/2), y[2]+(ctptsz/2))) {
        x[2] = x[2]+mouseX-pmouseX;
        y[2] = y[2]+mouseY-pmouseY;
      }
    }
  } //End msdrg method

  //  Mouse Over //
  void msovr() {
    if (mouseOver( l, t, r, bm)) msover = true;
    else msover = false;
  } //End msovr

  void msclk() {
    if (msover) {
      guiframe.gui.get(Textfield.class, "ONmsg").setText(oscadr);
      guiframe.gui.get(Textfield.class, "label").setText(label);
      guiframe.gui.get(Textfield.class, "desc").setText(desc);
    }
   
  }
  
  void msmvd() {
    if (msover) { 
      guiframe.gui.get(Textfield.class, "ONmsg").setText(oscadr);
      guiframe.gui.get(Textfield.class, "label").setText(label);
      guiframe.gui.get(Textfield.class, "desc").setText(desc);
    }
  }


  // ypos Method //
  float ypos(float xnow, int mode) {
    float curry;
    curry = getYPos(xnow, x[0], y[0], x[1], y[1], x[2], y[2], x[3], y[3]);
    if (mode==1) {
      fill(clr.getAlpha("yellow", 128));
      noStroke();
      ellipse(xnow, curry, crvflsz, crvflsz);
    }
    return curry;
  } //End ypos method

  ////////////////////////////////////
  /// METHODS FOR CURVE FOLLOWING ////
  ////////////////////////////////////
  int findroot(float x, float q0, float q1, float q2, float q3, float[] o) {
    // ripped straight from blenkernel/intern/fcurve.c : findzero()
    int nr = 0;
    float phi, a, b, c, p, q, d, c0, c1, c2, c3, t; // I've added this to the original function

    c0= q0 - x;
    c1= 3 * (q1 - q0);
    c2= 3 * (q0 - 2 * q1 + q2);
    c3= q3 - q0 + 3.0 * (q1 - q2);

    if (c3 != 0) {
      a= c2/c3;
      b= c1/c3;
      c= c0/c3;
      a= a/3;

      p= b/3 - a*a;
      q= (2*a*a*a - a*b + c) / 2;
      d= q*q + p*p*p;

      if (d > 0) {
        t= sqrt(d);
        o[0]= (sqrt3d(-q+t) + sqrt3d(-q-t) - a);

        if (o[0] >= SMALL && o[0] <= 1.000001) {
          return 1;
        } else {
          return 0;
        }
      } else if (d == 0) {
        t= sqrt3d(-q);
        o[0]= 2*t - a;

        if (o[0] >= SMALL && o[0] <= 1.000001) {
          nr = nr+1;
        }
        o[nr]= -t-a;

        if (o[nr] >= SMALL && o[nr] <= 1.000001) {
          return nr+1;
        } else {
          return nr;
        }
      } else {
        phi= acos(-q / sqrt(-(p*p*p)));
        t= sqrt(-p);
        p= cos(phi/3);
        q= sqrt(3 - 3*p*p);
        o[0]= 2*t*p - a;

        if (o[0] >= SMALL && o[0] <= 1.000001) {
          nr=nr+1;
        }
        o[nr]= -t * (p + q) - a;

        if (o[nr] >= SMALL && o[nr] <= 1.000001) {
          nr=nr+1;
        }
        o[nr]= -t * (p - q) - a;

        if (o[nr] >= SMALL && o[nr] <= 1.000001) {
          return nr+1;
        } else { 
          return nr;
        }
      }
    } else {
      a=c2;
      b=c1;
      c=c0;

      if (a != 0) {
        // discriminant
        p= b*b - 4*a*c;

        if (p > 0) {
          p= sqrt(p);
          o[0]= (-b-p) / (2 * a);

          if (o[0] >= SMALL && o[0] <= 1.000001) { 
            nr = nr+1;
          }
          o[nr]= (-b+p)/(2*a);

          if (o[nr] >= SMALL && o[nr] <= 1.000001) {
            return nr+1;
          } else { 
            return nr;
          }
        } else if (p == 0) {
          o[0]= -b / (2 * a);
          if (o[0] >= SMALL && o[0] <= 1.000001) {
            return 1;
          } else { 
            return 0;
          }
        }
      } else if (b != 0.0) {
        o[0]= -c/b;
        if (o[0] >= SMALL && o[0] <= 1.000001) { 
          return 1;
        } else { 
          return 0;
        }
      } else if (c == 0) {
        o[0]= 0;
        return 1;
      }  
      return 0;
    }
  }

  float sqrt3d(float d) {
    // ripped straight from blenlib/intern/math_base_inline.c
    if (d==0) {
      return 0;
    }
    if (d<0) {
      return -exp(log(-d)/3);
    } else {
      return exp(log(d)/3);
    }
  }


  PVector bezier2(float t, PVector A, PVector B, PVector C, PVector D) {
    float x = pow((1-t), 3)*A.x+3*pow((1-t), 2)*t*B.x+3*(1-t)*pow((t), 2)*C.x+pow((t), 3)*D.x;
    float y = pow((1-t), 3)*A.y+3*pow((1-t), 2)*t*B.y+3*(1-t)*pow((t), 2)*C.y+pow((t), 3)*D.y;
    PVector xy = new PVector(x, y);

    return xy;
  }


  float getYPos(float xSlider, float x0, float y0, float x1, float y1, float x2, float y2, float x3, float y3) {
    b = findroot(xSlider, x0, x1, x2, x3, OPL);
    if (b==1) {
      PVector xy = bezier2(OPL[0], new PVector(x0, y0), new PVector(x1, y1), new PVector(x2, y2), new PVector(x3, y3)); 
      yLookup = xy.y;
    }
    return yLookup;
  }
  //////////////////////////////////////////
  //// END METHODS FOR CURVE FOLLOWING ////
  /////////////////////////////////////////
} // End class BezierCurve

//// CLASS SET CLASS ////
class BezierSet {
  ArrayList<BezierCurve> clst = new ArrayList<BezierCurve>();

  // Make Instance Method //
  void mk(int ix, String clr, int anchorpt1x, int anchorpt1y, int ctlpt1x, int ctlpt1y, 
  int ctlpt2x, int ctlpt2y, int anchorpt2x, int anchorpt2y, String oscadr) {
    clst.add( new BezierCurve( ix, clr, anchorpt1x, anchorpt1y, ctlpt1x, ctlpt1y, 
    ctlpt2x, ctlpt2y, anchorpt2x, anchorpt2y, 
    oscadr ) );
  } //end mk method

  // Draw Set Method //
  void dr() {
    for (int i=clst.size ()-1; i>=0; i--) {
      BezierCurve inst = clst.get(i);
      inst.drw();
      //CURSOR CURVE FOLLOWING
      //Are there any cursors yet?
      if (csrs.clst.size()!=0) {
        //for loop for cursor set
        for (int j=csrs.clst.size ()-1; j>=0; j--) {
          Csr instcsr = csrs.clst.get(j);   
          //Is the cursor touching a curve
          if (instcsr.x >= inst.x[0] && instcsr.x <= inst.x[3] && 
            instcsr.y1 <= inst.ypos(instcsr.x, 0) && instcsr.y2 >= inst.ypos(instcsr.x, 0) ) {
            inst.ypos(instcsr.x, 1); //draws ypos indicator on curve
            //trigger on when cursor hits curve
            if (!inst.on) {
              inst.on = true;
              //  println(inst.clrnum);
            }
            //Normalized curve height data
            float normcrvH = norm( inst.ypos(instcsr.x, 0), instcsr.y2, instcsr.y1);
            println(inst.oscadr + " : " + normcrvH);
            meosc.send(inst.oscadr, new Object[] {
              normcrvH
            }
            , splscore);
          }
          //trigger off when cursor leaves curve
          else {
            //trigger off when cursor leaves curve
            if (inst.on) {
              inst.on = false;
              // println(inst.clrnum);
              //  println(inst.clrname);
            }
          }
        }
      }
    }
  } //end msdrg method // Draw Set Method //
  void msdrg() {
    for (int i=clst.size ()-1; i>=0; i--) {
      BezierCurve inst = clst.get(i);
      inst.msdrg();
    }
  } //end msdrg method

  // Mouse Pressed Set Method //
  void msclk() {
    for (int i=clst.size ()-1; i>=0; i--) {
      BezierCurve inst = clst.get(i);
      inst.msclk();
    }
  } //end msclk method

  // Mouse Pressed Set Method //
  void msmvd() {
    for (int i=clst.size ()-1; i>=0; i--) {
      BezierCurve inst = clst.get(i);
      inst.msmvd();
    }
  } //end msclk method
} //end class set class

