class Hexview {
  Memory mem;
  int[] hilights;
  PFont  font;
  
  Hexview(Memory m) {
    mem = m;
    font = createFont("Consolas", 12);
    hilights = new int[m.getSize()];
  }
  
  void clearHilights() {
    for (int i = 0; i < hilights.length; i++) {
      hilights[i % hilights.length] = 0;
    }
  }
  
  void setHilight(int addr, int h) {
    hilights[addr % hilights.length] = h;
  }
  
  void draw() {
    textFont(font);
    int size = mem.getSize();
    int idx = 0;
    int val = 0;
    String wat;
    char chr;
    String blank = "--";
    char cBlank = '.';
    
    for (int y = 0; y < 32 ; y++) {
      for (int x = 0; x < 16 ; x++) {
          chr = cBlank;     
          if (idx >= size) {
            wat = blank;
          }
          else {
            val = mem.get(idx);
            wat = String.format("%02x", (short) val & 0xFF);
            if (val > 31 && val < 127) {
              chr = (char) val;
            }
            
          }
           
          if (hilights[idx] > 0) { 
            fill(0,128 + (frameCount % 64) * 2 ,0);
          }
          else {
            fill(255,255,255);
          }
 
          text(wat, x * 16, 16 + (y * 16));
          text(chr, (16 + (16 * 16)) + x * 8, 16 + (y * 16)); 
                   
          idx++;
      }
    } 
  }
}
