//make bounding box
//preset constructor 
//framerate clock

class Win {
  // CONSTRUCTOR VARIALBES //
  int ix;
  int bdr, fil, bdrclr;
  float x, y, w, h;
  float tladdpx;

  // CLASS VARIABLES //
  float t, b;
  int numsecinwin;
  float secRemainderPx;
  float timelinepxadj;
  float timelineadj;
  float[]secmarklocs;

  // CONSTRUCTORS //
  //Constructor 1 - Standard Window(noborder, default size/color/location)
  Win(int aix, int ax, int ay, int aw, int ah, float atladdpx) {
    ix = aix;
    x = ax;
    y = ay;
    w = aw;
    h = ah;
    tladdpx = atladdpx;
    fil = clr.get("TranquilBlue");
    bdr = 0;
    secRemainderPx = ((w-tladdpx)/pxpersec) - floor((w-tladdpx)/pxpersec);
    timelinepxadj = (1 - secRemainderPx)*pxpersec;
    timelineadj = 1 - secRemainderPx;
    numsecinwin = ceil( (w-tladdpx)/pxpersec );
    secmarklocs = new float[numsecinwin];
    for (int i=0; i<secmarklocs.length; i++) {
      secmarklocs[i] = (pxpersec*i)+tladdpx;
    }
    t = y;
    b = y+h;
  } //end constructor 1

  //  DRAW METHOD //
  void drw() {
    //Border
    if (bdr == 0) noStroke();
    else { 
      strokeWeight(bdr); 
      stroke(bdrclr);
    }
    //Fill
    fill(0);
    //Make Window
    rect(x, y, w, h);
    //Make Time Marks
    stroke(clr.get("yellow"));
    strokeWeight(1);
    for (int i=0; i<secmarklocs.length; i++) {
      line(secmarklocs[i]+x, y, secmarklocs[i]+x, y-5);
    }
    //Indication every 10 seconds
    for (int i=0; i<secmarklocs.length; i++) {
      if ( ( i + round((ix*durstave)+timelineadj) )%5 == 0 ) {
        fill(clr.get("yellow"));
        textFont(font1);
        textAlign(CENTER, BOTTOM);
        textSize(12);
        text(i + round((ix*durstave)+timelineadj), secmarklocs[i]+x, y-5-2);
      }
    }
  } //End drw
}  //End class

//// CLASS SET CLASS ////
class WinSet {
  ArrayList<Win> clst = new ArrayList<Win>();

  // Make Instance Method //
  void mkins(int ix, int x, int y, int w, int h, float tladdpx) {
    clst.add(new Win(ix, x, y, w, h, tladdpx));
  } //end mk method

  // Draw Set Method //
  void drst() {
    for (int i=clst.size ()-1; i>=0; i--) {
      Win inst = clst.get(i);
      inst.drw();
    }
  } //end dr method

  // Draw Set Method //
  void fillcanvas(int numwin) {
    int sp = height - (cvmar*2); //amount of available space in pixels
    int winsz = ( height - (cvmar*2) - (wingap*(numwin-1)) )/numwin; //the win size is = (height - top&bottom margins - (numwins-1 number of gaps)) all devided by numwins
    int ix = 0; //counter
    if (clst.size() == 0) { //check to see if there are already windows
      while ( (sp)>0 ) { //while there is space left for a window 
        if (ix==0) mkins(ix, cvmar, cvmar + (ix*(winsz+wingap)), defaultWinW, winsz, 0.0);
        else {
          Win inst = clst.get(ix-1);
          mkins(ix, cvmar, cvmar + (ix*(winsz+wingap)), defaultWinW, winsz, inst.timelinepxadj);
        }
        sp = sp - winsz - wingap;
        ix++;
      }
    }
  } //end fill canvas method
} //end class set class

