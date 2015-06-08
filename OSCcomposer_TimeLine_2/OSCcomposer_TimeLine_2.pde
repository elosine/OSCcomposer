//IMPORT LIBRARIES
import oscP5.*;
import netP5.*;
import java.awt.Frame;
import java.awt.BorderLayout;
import controlP5.*;
import java.util.Arrays;


////  GLOBAL VARIABLES  ////

// Control P5 //
private ControlP5 gui;
ControlFrame guiframe;

// Init //
int frmrate = 60;

boolean makecrv = true;

// Canvas //
int cvmar = 50; //margins
int wingap = 30; //gap between windows

// Score Timing //
float scrlngpx = 0.0;
float scrdursec = 0.0;
float secperpx = 0.0;
float pxpersec = 0.0;
float pxperframe = 0.0;
float scrnumwin = 0.0;
float durframes = 0.0;
float secperframe = 0.0;
float durstave = 0.0;
PFont font1, monaco18, monaco10, monaco13;


// OSC //
OscP5 meosc;
NetAddress splscore;

BezierSet beziers;
ColorSwatch cs;

//GUI ELEMENTS
int gap = 30;
int guix;
int guiy;
ButtonSet btns;
TextBoxSet tbs;

int presetmenux = 10;
int presetmenuy = 400;
int psct = 1;

int bzix = 0;
int brkix = 0;

/// Windows ///
WinSet wins;
int defaultWinHt = 200;
int defaultWinW;

/// Cursors ///
CsrSet csrs;

int brickct = 0;

String[] psdescs = new String[13];
String psdesctemp = "";



void setup() {
  // Init //
  size(1150, 800);
  smooth();
  frameRate(frmrate);
  for (int i=0; i<psdescs.length; i++) psdescs[i]="Add preset description, and press RETURN";

  font1 = loadFont("Monaco-12.vlw");
  monaco18 = loadFont("Monaco-18.vlw");
  monaco10 = loadFont("Monaco-10.vlw");
  monaco13 = loadFont("Monaco-13.vlw");
  textAlign(CENTER);

  // Control P5 //
  gui = new ControlP5(this);
  guiframe = addCtrlFrame("Object Maker", 1150, 230);


  // OSC //
  meosc = new OscP5(this, 54321);
  splscore = new NetAddress("127.0.0.1", 57120);

  // Init Score Plug //
  meosc.plug(this, "initscore", "/initscore");

  // CLASSES //

  /// Windows ///
  wins = new WinSet();
  meosc.plug(wins, "mkins", "/mkwin");
  meosc.plug(wins, "fillcanvas", "/fillcanvas");

  /// Cursors ///
  csrs = new CsrSet();
  meosc.plug(csrs, "mkins", "/mkcsr");
  meosc.plug(csrs, "play", "/playcsr");
  meosc.plug(csrs, "pause", "/pausecsr");


  // Canvas //
  defaultWinW = width  - 115 - (cvmar*2);

  // CLASSES //
  beziers = new BezierSet();
  btns = new ButtonSet();
  tbs = new TextBoxSet();

  //GUI ELEMENTS
  guix = width-130;
  guiy = 0;
  //COLOR SWATCH
  cs = new ColorSwatch(guix, gap + 100 + 50, 4, 25);
  // btns.mkact(0, guix, gap, 30, 30, "white", "indigo", "green", "green", 0);
  //  tbs.mkclr(0, guix+30+15, gap, 50, 30, "darkorange", "white", "slateblue", "goldenrod"); //idx

  initscore(180.0, 5);
  csrs.play(0, 1, 1.0);
}

void draw() {
  background(clr.get("TranquilBlue"));
  // Windows //
  wins.drst();
  tbs.dr();
  beziers.dr();
  cs.dr();
  btns.dr();
  bricks.dr();
  // Cursors //
  csrs.drst();

  //GUI
  // BRICK ICON //
  noStroke();
  fill(clr.get("violetred"));
  rectMode(CORNER);
  rect(guix, guiy+gap, 100, 30);

  // CURVE ICON //
  noStroke();
  fill(clr.get("dodgerblue"));
  rectMode(CORNER);
  rect(guix, guiy+gap+50, 100, 70);
  noFill();
  strokeWeight(3);
  stroke(clr.get("nicegreen"));
  bezier(guix, guiy+100+50, guix+50, guiy+100+50, guix+50, guiy+gap+50, guix+100, guiy+gap+50);

  // color swatch mouse over behavior //

  if (mouseOver(cs.bl, cs.bt, cs.br, cs.bb)) {
    for (int i=0; i<beziers.clst.size (); i++) {
      BezierCurve bz = beziers.clst.get(i);

      if (bz.active) {
        bz.crvclr = clr.get(cs.msovrname);
        bz.clrname = cs.msovrname;
        bz.clrnum = cs.msovernum;
      }
    }

    for (int i=0; i<bricks.cset.size (); i++) {
      Brick brk = bricks.cset.get(i);

      if (brk.active) {
        brk.fillclr = cs.msovrname;
      }
    }
  }


  //
} //end draw

void mouseDragged() {
  beziers.msdrg();
  bricks.msdrg();
}

void keyPressed() {
  tbs.keyprs();
  bricks.keyprs();
  // if(key=='i') saveScore();
  //if(key=='j') loadScore("score1.txt");

  if (keyCode==BACKSPACE) {
    for (int i=0; i<bricks.cset.size (); i++) {
      Brick inst = bricks.cset.get(i);
      if (inst.active) {
        bricks.cset.remove(i);
        break;
      }
    }
  }
}

void mousePressed() {
  btns.msclk();
  tbs.msclk();
  bricks.msclk();
  beziers.msclk();
  ////BRICK ICON CLICKED
  if (mouseOver(guix, guiy+gap, guix+100, guiy+gap+30)) {
    bricks.mkclr(200, 70, 100, 30, "none", "violetred", "goldenrod", "orange");
    brkix++;
  }
  //CURVE ICON CLICKED
  if (mouseOver(guix, guiy+gap+50, guix+100, guiy+gap+50+70)) {
    beziers.mk(bzix, "nicegreen", 100, 200, 50, 0, -50, 0, 200, 130, "/curvie");
    bzix++;
  }
}



void mouseMoved() {
  boolean clronmsg = true;
  boolean updatetf = true;
  for (int i=bricks.cset.size ()-1; i>=0; i--) {
    Brick inst = bricks.cset.get(i);
    if (inst.active) { 
      clronmsg = false;
      break;
    } 
    //
    else if (inst.msover) {
      clronmsg = false;
      break;
    }
  }
  for (int i=bricks.cset.size ()-1; i>=0; i--) {
    Brick inst = bricks.cset.get(i);
    if (inst.active) { 
      updatetf = false;
    }
  }
  
  for (int i=beziers.clst.size ()-1; i>=0; i--) {
    BezierCurve inst = beziers.clst.get(i);
    if (inst.active) { 
      clronmsg = false;
      break;
    } 
    //
    else if (inst.msover) {
      clronmsg = false;
      break;
    }
  }
  
  for (int i=beziers.clst.size ()-1; i>=0; i--) {
    BezierCurve inst = beziers.clst.get(i);
    if (inst.active) { 
      updatetf = false;
    }
  }

  if (clronmsg) {
    guiframe.gui.get(Textfield.class, "ONmsg").clear();
    guiframe.gui.get(Textfield.class, "label").clear();
    guiframe.gui.get(Textfield.class, "offmsg").clear();
    guiframe.gui.get(Textfield.class, "desc").clear();
  }

  if (updatetf){
    bricks.msmvd();
    beziers.msmvd();
  }
}

