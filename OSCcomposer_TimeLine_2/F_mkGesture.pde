
class MkGesture {
  float start, end;
  float dur;
  float[] discreteEventsSt = new float[0];
  float[] discreteEventsEnd = new float[0];
  int numstf = int(scrnumwin);
  float[][] staffTB = new float[numstf][2];
  MkGesture(float astart, float aend) {
    start = astart;
    end = aend;
    dur = end - start;
  }

  void calc() {
    //calc top and bottom for each staff
    for (int i=wins.clst.size ()-1; i>=0; i--) {
      Win inst = wins.clst.get(i);
      staffTB[i][0] = inst.t;
      staffTB[i][1] = inst.b;
    }

    //Calculations for each brick
    for (int i=bricks.cset.size ()-1; i>=0; i--) {
      Brick inst = bricks.cset.get(i);
      //get current time and normalize
      int stfnum = 0;
      for (int j=0; j<numstf; j++) {
        if (inst.c>=staffTB[j][0] && inst.c<=staffTB[j][1]) {
          stfnum = j;
        }
      }

      Win w = wins.clst.get(stfnum);
      float stavebegin = w.x;
      float stavew = w.w;
      float bst = (durstave*stfnum) + map(inst.l, stavebegin, stavebegin+stavew, 0.0, durstave);
      float bend = (durstave*stfnum) + map(inst.r, stavebegin, stavebegin+stavew, 0.0, durstave);

      if (bst>=start && bend<=end) {
        float zstart = bst-start;
        float startnorm = zstart/dur;
        float zend = bend-start;
        float endnorm = zend/dur;

        discreteEventsSt = append(discreteEventsSt, startnorm);
        discreteEventsEnd = append(discreteEventsEnd, endnorm);
      }
    }
    //
    //
  }//end calc method
  //
} //end class

