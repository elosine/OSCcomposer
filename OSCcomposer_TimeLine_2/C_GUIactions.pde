GUIactions guiactions = new GUIactions();
class GUIactions{
  
   String aclrname;
      float aanchorpt1x, aanchorpt1y, actlpt1xr, actlpt1yr, actlpt2xr, actlpt2yr, aanchorpt2x, aanchorpt2y;
      float aloc, adur;
      int aix;
  
  void mk(int tp) {
    switch(tp) {
    case 0:
    
  for (int i=0; i<tbs.cset.size (); i++) {
      TextBox tb = tbs.cset.get(i);
 
        if (tb.ix == 0) {
          aix = int(tb.txt);
          println(aix);
        }
    }
      for (int i=0; i<beziers.clst.size (); i++) {
      BezierCurve bz = beziers.clst.get(i);
        if (bz.ix == aix) {
          aclrname = bz.clrname;
          aanchorpt1x = bz.x[0];
          aanchorpt1y = bz.y[0];
          actlpt1xr = bz.x[1];
          actlpt1yr = bz.y[1];
          actlpt2xr = bz.x[2];
          actlpt2yr = bz.y[2];
          aanchorpt2x = bz.x[3];
          aanchorpt2y = bz.y[3];
          break;
        }
    }
  
      //meosc.send( "/tlevent", Object[]{ aclrname, aanchorpt1x, aanchorpt1y, actlpt1xr, 
     // actlpt1yr, actlpt2xr, actlpt2yr, aanchorpt2x, aanchorpt2y }, tlscore );
     println( aclrname + " " + aanchorpt1x + " " + aanchorpt1y + " " + actlpt1xr + " " +  
     actlpt1yr + " " + actlpt2xr + " " + actlpt2yr + " " + aanchorpt2x + " " + aanchorpt2y );

      break;
      case 1:
      //send timelines score data
     
    
      for (int i=0; i<tbs.cset.size (); i++) {
      TextBox tb = tbs.cset.get(i);
        if (tb.ix == 0) {
          aloc = float(tb.txt);
        }
        if (tb.ix == 1) {
          adur = float(tb.txt);
        }
        if (tb.ix == 2) {
          aix = int(tb.txt);
        }
    }
    
      for (int i=0; i<beziers.clst.size (); i++) {
      BezierCurve bz = beziers.clst.get(i);
        if (bz.ix == aix) {
          aclrname = bz.clrname;
          aanchorpt1x = bz.x[0];
          aanchorpt1y = bz.y[0];
          actlpt1xr = bz.x[1];
          actlpt1yr = bz.y[1];
          actlpt2xr = bz.x[2];
          actlpt2yr = bz.y[2];
          aanchorpt2x = bz.x[3];
          aanchorpt2y = bz.y[3];
          break;
        }
    }
  
      //meosc.send( "/tlevent", Object[]{ aclrname, aanchorpt1x, aanchorpt1y, actlpt1xr, 
     // actlpt1yr, actlpt2xr, actlpt2yr, aanchorpt2x, aanchorpt2y, aloc, adur }, tlscore );
     println( aclrname + " " + aanchorpt1x + " " + aanchorpt1y + " " + actlpt1xr + " " +  
     actlpt1yr + " " + actlpt2xr + " " + actlpt2yr + " " + aanchorpt2x + " " + aanchorpt2y + " " + aloc + " " + adur);
    }
  }


  //
}  //end class

