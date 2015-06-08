
void saveScore(String filename, int presetnum) {
  boolean storegate = false;
  String filepath = "data/" + filename;
  String[] dataArray = new String[0];
  int ver = 1;

  for (Brick inst : bricks.cset) {
    // string identifying GUI object
    String tempstr = 
      str(inst.x) + "," +  
      str(inst.y) + "," +  
      str(inst.w) + "," +  
      str(inst.h) + "," +    
      inst.fillclr + "," + 
      inst.label + "," + 
      inst.desc + 
      ";" +  
      inst.onmsgsStr +  
      ";" +   
      inst.offmsgsStr ;
    dataArray = append(dataArray, tempstr);
  }
  dataArray = append(dataArray, psdescs[presetnum]);
  saveStrings(filepath, dataArray); 

  /*
TO CREATE NEW STORE FILES WITHOUT ERASING PREVIOUS ONES
   while (!storegate) {
   String[] loc = null;
   loc = loadStrings(filepath);
   
   if (loc == null) {
   saveStrings(filepath, dataArray); 
   storegate = true;
   break;
   } 
   //
   else { 
   filepath = "data/" + filename + str(ver) + ".txt";
   ver++;
   }
   }
   */
}

