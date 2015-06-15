class Hexview {
  Memory mem;
  int[] hilights;
  float textWidth;
  float textHeight;
  float boxWidth;
  float boxHeight;

  Hexview(Memory m) {
    mem = m;
    hilights = new int[m.getSize()];
    textWidth = 1.1 * textWidth("#");
    textHeight = 1.5 * textWidth;
    boxWidth = (8 + (16 * 4)) * textWidth;
    boxHeight = (33 * textHeight);
       
    println("tw: " + textWidth);
  }

  void clearHilights() {
    for (int i = 0; i < hilights.length; i++) {
      hilights[i] = 0;
    }
  }

  void setHilight(int addr, int h) {
    hilights[addr % hilights.length] = h;
  }

  // draw text at x, y text units, not pixels
  void drawText(String text, int x, int y) {
    text(text, textWidth + (x * textWidth), textHeight + (y * textHeight));
  }

  void draw() {
    int size = mem.getSize();
    int idx = 0;
    int val = 0;
    String wat;
    char chr;
    String blank = "--";
    char cBlank = ' ';

    
    // box is 1 + (16 * 3) + 16 characters wide, 32 characters high.
    noFill();
    stroke(0, 0, 100);
    rect(0, 0, boxWidth, boxHeight);
    line((6 + (16 * 3)) * textWidth, 0, (6 + (16 * 3)) * textWidth, boxHeight);


    for (int y = 0; y < 32; y++) {
      drawText(String.format("%04x", y * 16), 0, y);

      for (int x = 0; x < 16; x++) {
        chr = cBlank;     
        if (idx >= size) {
          wat = blank;
        } else {
          val = (short) mem.get(idx) & 255;
          wat = String.format("%02X", (short) val & 0xFF);
          if (val > 31 && val < 128) {
            chr = (char) val;
          }
          else {
            chr = '.';
          }
        }

        if (idx < hilights.length && hilights[idx] > 0) {
          if (hilights[idx] > 1) { 
            fill(10 * (hilights[idx] + 1), 100, 100);
          }
        } else {
          fill(0, 0, 100);
        }

        drawText(wat, 5 + (x * 3) , y);
        drawText("" + chr, 6 + (16 * 3) + x, y);

        idx++;
      }
    }
  }
}

