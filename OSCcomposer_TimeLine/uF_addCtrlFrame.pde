ControlFrame addCtrlFrame(String name, int fw, int fh) {
  Frame f = new Frame(name);
  ControlFrame p = new ControlFrame(this, fw, fh);
  f.add(p);
  p.init();
  f.setTitle(name);
  f.setSize(p.w, p.h);
  f.setLocation(400, 20);
  f.setResizable(false);
  f.setVisible(true);
  return p;
}

public class ControlFrame extends PApplet {

  int w, h;

  int abc = 100;
  Textfield psd;

  public void setup() {
    size(w, h);
    //frameRate(25);
    //imgs = {b1, b1, b1};
    gui = new ControlP5(this);

    gui.addTextfield("ONmsg")
      .setPosition(60, 10)
        .setSize(1050, 32)
          .setFont(monaco18)
            .setColorBackground(0)
              .setColor(clr.get("green"))
                .setAutoClear(true);

    gui.getController("ONmsg").captionLabel().getStyle().setMargin(-28, 0, 0, -46);
    gui.getController("ONmsg").captionLabel().setColor(clr.get("yellow"));
    // gui.getController("ONmsg").captionLabel().setSize(11);
    gui.getController("ONmsg").captionLabel().setFont(monaco13);


    gui.addTextfield("offmsg")
      .setPosition(60, 49)
        .setSize(1050, 32)
          .setFont(monaco18)
            .setColorBackground(0)
              .setColor(clr.get("green"))
                .setAutoClear(true);

    gui.getController("offmsg").captionLabel().getStyle().setMargin(-28, 0, 0, -53);
    gui.getController("offmsg").captionLabel().setColor(clr.get("yellow"));
    gui.getController("offmsg").captionLabel().setFont(monaco13);

    gui.addTextfield("desc")
      .setPosition(60, 88)
        .setSize(1050, 32)
          .setFont(monaco18)
            .setColorBackground(0)
              .setColor(clr.get("green"))
                .setAutoClear(true);

    gui.getController("desc").captionLabel().getStyle().setMargin(-28, 0, 0, -38);
    gui.getController("desc").captionLabel().setColor(clr.get("yellow"));
    gui.getController("desc").captionLabel().setFont(monaco13);


    gui.addTextfield("label")
      .setPosition(60, 127)
        .setSize(1050, 32)
          .setFont(monaco18)
            .setColorBackground(0)
              .setColor(clr.get("green"))
                .setAutoClear(true);

    gui.getController("label").captionLabel().getStyle().setMargin(-28, 0, 0, -43);
    gui.getController("label").captionLabel().setColor(clr.get("yellow"));
    gui.getController("label").captionLabel().setFont(monaco13);

    // Presets //
    gui.addButton("p1")
      .setSize(25, 25)
        .setPosition(20, 175)
          .addCallback(  
          new CallbackListener() {
            public void controlEvent(CallbackEvent theEvent) {
              switch(theEvent.getAction()) {
                case(ControlP5.ACTION_PRESSED):
                if (keyPressed) {
                  if (keyCode==SHIFT) {
                    psdescs[0] = psdesctemp;
                    saveScore("p1.txt", 0);
                  } else if (keyCode==CONTROL) {
                    bricks.cset.clear();
                    loadScore("p1.txt", 0);
                  }
                }              
                break;

                case(ControlP5.ACTION_RELEASED):
                case(ControlP5.ACTION_RELEASEDOUTSIDE):
                if (!keyPressed) loadScore("p1.txt", 0);
                break;
              }
            }
          }
    );








    gui.addButton("p2")
      .setSize(25, 25)
        .setPosition(50, 175);
    gui.addButton("p3")
      .setSize(25, 25)
        .setPosition(80, 175);
    gui.addButton("p4")
      .setSize(25, 25)
        .setPosition(110, 175);
    gui.addButton("p5")
      .setSize(25, 25)
        .setPosition(140, 175);
    gui.addButton("p6")
      .setSize(25, 25)
        .setPosition(170, 175);
    gui.addButton("p7")
      .setSize(25, 25)
        .setPosition(200, 175);
    gui.addButton("p8")
      .setSize(25, 25)
        .setPosition(230, 175);
    gui.addButton("p9")
      .setSize(25, 25)
        .setPosition(260, 175);
    gui.addButton("p10")
      .setSize(25, 25)
        .setPosition(290, 175);
    gui.addButton("p11")
      .setSize(25, 25)
        .setPosition(320, 175);
    gui.addButton("p12")
      .setSize(25, 25)
        .setPosition(350, 175);
    gui.addButton("p13")
      .setSize(25, 25)
        .setPosition(380, 175);
    gui.addButton("CLEAR")
      .setSize(50, 25)
        .setPosition(410, 175);

    psd = gui.addTextfield("psdesc")
      .setPosition(465, 172)
        .setSize(645, 32)
          .setFont(monaco18)
            .setColorBackground(0)
              .setColor(clr.get("green"))
                .setAutoClear(false);


    //
    //
  }


  public void draw() {
    background(clr.get("beet"));
    if ( gui.isMouseOver(gui.getController("p1")) ) psd.setText(psdescs[0]);
    if ( gui.isMouseOver(gui.getController("p2")) ) psd.setText(psdescs[1]);
    if ( gui.isMouseOver(gui.getController("p3")) ) psd.setText(psdescs[2]);
    if ( gui.isMouseOver(gui.getController("p4")) ) psd.setText(psdescs[3]);
    if ( gui.isMouseOver(gui.getController("p5")) ) psd.setText(psdescs[4]);
    if ( gui.isMouseOver(gui.getController("p6")) ) psd.setText(psdescs[5]);
    if ( gui.isMouseOver(gui.getController("p7")) ) psd.setText(psdescs[6]);
    if ( gui.isMouseOver(gui.getController("p8")) ) psd.setText(psdescs[7]);
    if ( gui.isMouseOver(gui.getController("p9")) ) psd.setText(psdescs[8]);
    if ( gui.isMouseOver(gui.getController("p10")) ) psd.setText(psdescs[9]);
    if ( gui.isMouseOver(gui.getController("p11")) ) psd.setText(psdescs[10]);
    if ( gui.isMouseOver(gui.getController("p12")) ) psd.setText(psdescs[11]);
    if ( gui.isMouseOver(gui.getController("p13")) ) psd.setText(psdescs[12]);
  } 


  public void psdesc(String amsg) {
    psdesctemp = amsg;
  }

//Here we set timeline objects from composer interface text boxes
  public void ONmsg(String amsg) {
    for (int i=bricks.cset.size ()-1; i>=0; i--) {
      Brick inst = bricks.cset.get(i);
      if (inst.active) {
        inst.onmsgsStr = amsg;
        inst.mkOscMsgOn();
        break;
      }
    }
    for (int i=beziers.clst.size ()-1; i>=0; i--) {
      BezierCurve inst = beziers.clst.get(i);
      if (inst.active) {
        inst.oscadr = amsg;
        break;
      }
    }
  }


  public void offmsg(String amsg) {
    // automatically receives results from controller input
    for (int i=bricks.cset.size ()-1; i>=0; i--) {
      Brick inst = bricks.cset.get(i);
      if (inst.active) {
        inst.offmsgsStr = amsg;
        inst.mkOscMsgOff();
        break;
      }
    }
  }


  public void desc(String amsg) {
    // automatically receives results from controller input
    for (int i=bricks.cset.size ()-1; i>=0; i--) {
      Brick inst = bricks.cset.get(i);
      if (inst.active) {
        inst.desc = amsg;
        break;
      }
    }
  }


  public void label(String amsg) {
    // automatically receives results from controller input
    for (int i=bricks.cset.size ()-1; i>=0; i--) {
      Brick inst = bricks.cset.get(i);
      if (inst.active) {
        inst.label = amsg;
        break;
      }
    }
  }

  public void CLEAR(int theValue) {
    bricks.cset.clear();
  }


  public void p2(int theValue) {
    if (keyPressed) {
      if (keyCode==SHIFT) {
        psdescs[1] = psdesctemp;
        saveScore("p2.txt", 1);
      } else if (keyCode==CONTROL) {
        bricks.cset.clear();
        loadScore("p2.txt", 1);
      }
    } else loadScore("p2.txt", 1);
  }

  public void p3(int theValue) {
    if (keyPressed) {
      if (keyCode==SHIFT) {
        psdescs[2] = psdesctemp;
        saveScore("p3.txt", 2);
      } else if (keyCode==CONTROL) {
        bricks.cset.clear();
        loadScore("p3.txt", 2);
      }
    } else loadScore("p3.txt", 2);
  }

  public void p4(int theValue) {
    if (keyPressed) {
      if (keyCode==SHIFT) {
        psdescs[3] = psdesctemp;
        saveScore("p4.txt", 3);
      } else if (keyCode==CONTROL) {
        bricks.cset.clear();
        loadScore("p4.txt", 3);
      }
    } else loadScore("p4.txt", 3);
  }

  public void p5(int theValue) {
    if (keyPressed) {
      if (keyCode==SHIFT) {
        psdescs[4] = psdesctemp;
        saveScore("p5.txt", 4);
      } else if (keyCode==CONTROL) {
        bricks.cset.clear();
        loadScore("p5.txt", 4);
      }
    } else loadScore("p5.txt", 4);
  }

  public void p6(int theValue) {
    if (keyPressed) {
      if (keyCode==SHIFT) {
        psdescs[5] = psdesctemp;
        saveScore("p6.txt", 5);
      } else if (keyCode==CONTROL) {
        bricks.cset.clear();
        loadScore("p6.txt", 5);
      }
    } else loadScore("p6.txt", 5);
  }

  public void p7(int theValue) {
    if (keyPressed) {
      if (keyCode==SHIFT) {
        psdescs[6] = psdesctemp;
        saveScore("p7.txt", 6);
      } else if (keyCode==CONTROL) {
        bricks.cset.clear();
        loadScore("p7.txt", 6);
      }
    } else loadScore("p7.txt", 6);
  }

  public void p8(int theValue) {
    if (keyPressed) {
      if (keyCode==SHIFT) {
        psdescs[7] = psdesctemp;
        saveScore("p8.txt", 7);
      } else if (keyCode==CONTROL) {
        bricks.cset.clear();
        loadScore("p8.txt", 7);
      }
    } else loadScore("p8.txt", 7);
  }

  public void p9(int theValue) {
    if (keyPressed) {
      if (keyCode==SHIFT) {
        psdescs[8] = psdesctemp;
        saveScore("p9.txt", 8);
      } else if (keyCode==CONTROL) {
        bricks.cset.clear();
        loadScore("p9.txt", 8);
      }
    } else loadScore("p9.txt", 8);
  }

  public void p10(int theValue) {
    if (keyPressed) {
      if (keyCode==SHIFT) {
        psdescs[9] = psdesctemp;
        saveScore("p10.txt", 9);
      } else if (keyCode==CONTROL) {
        bricks.cset.clear();
        loadScore("p10.txt", 9);
      }
    } else loadScore("p10.txt", 9);
  }

  public void p11(int theValue) {
    if (keyPressed) {
      if (keyCode==SHIFT) {
        psdescs[10] = psdesctemp;
        saveScore("p11.txt", 10);
      } else if (keyCode==CONTROL) {
        bricks.cset.clear();
        loadScore("p11.txt", 10);
      }
    } else loadScore("p11.txt", 10);
  }

  public void p12(int theValue) {
    if (keyPressed) {
      if (keyCode==SHIFT) {
        psdescs[11] = psdesctemp;
        saveScore("p12.txt", 11);
      } else if (keyCode==CONTROL) {
        bricks.cset.clear();
        loadScore("p12.txt", 11);
      }
    } else loadScore("p12.txt", 11);
  }

  public void p13(int theValue) {
    if (keyPressed) {
      if (keyCode==SHIFT) {
        psdescs[12] = psdesctemp;
        saveScore("p13.txt", 12);
      } else if (keyCode==CONTROL) {
        bricks.cset.clear();
        loadScore("p13.txt", 12);
      }
    } else loadScore("p13.txt", 12);
  }


  private ControlFrame() {
  }

  public ControlFrame(Object theParent, int theWidth, int theHeight) {
    parent = theParent;
    w = theWidth;
    h = theHeight;
  }


  public ControlP5 control() {
    return gui;
  }


  ControlP5 gui;

  Object parent;
}

