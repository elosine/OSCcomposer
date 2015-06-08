void loadScore(String scorename, int psnum) {
  String[] score = {
    ""
  };
  if (loadStrings("data/" + scorename) != null) { 
   
    score = loadStrings("data/" + scorename);
    psdescs[psnum] = score[score.length-1];
    score = shorten(score);
    for (int i=0; i<score.length; i++) {
      String[] chunks = split(score[i], ";");
      String[] chunksA = split(chunks[0], ",");
      int x = int(chunksA[0]);
      int y = int(chunksA[1]);
      int w = int(chunksA[2]);
      int h = int(chunksA[3]);
      String fillclr = chunksA[4];
      String label = chunksA[5];
      String desc = chunksA[6];
      
      
      String onmsgsStr = chunks[1];
      String offmsgsStr = chunks[2];
      bricks.mkscore( x, y, w, h, fillclr, label, desc, onmsgsStr, offmsgsStr);
    }
  }
}

