class DisassemblerView {
  Memory mem;
  float textWidth;
  float textHeight;
  float boxWidth;
  float boxHeight;
  int loc;
  int nInstr;
  Assembler asm;

  DisassemblerView(Memory _mem, int _n) {
    loc = 0;
    mem = _mem;
    textWidth = 1.1 * textWidth("#");
    textHeight = 1.5 * textWidth;
    nInstr = _n;
    boxHeight = (2 + _n) * textHeight;
    boxWidth  = (2 + 18) * textWidth;
    asm = new Assembler();
  }

  void setLoc(int _loc) {
    loc = mem.normaliseAddr(_loc);
  }

  // draw text at x, y text units, not pixels
  void drawText(String text, int x, int y) {
    text(text, textWidth + (x * textWidth), textHeight + (y * textHeight));
  }

  void display() {
    noFill();
    stroke(0, 0, 100);
    rect(0, 0, boxWidth, boxHeight);
    drawText("*** CODE VIEW ***", 0, 0);
    
    for (int i = 0; i < nInstr; i++) {
      int pc = mem.normaliseAddr(loc + (i * 2));
      byte b1 = mem.get(pc);
      byte b2 = mem.get(pc + 1);
      String dis = myAssembler.dis(b1, b2);
      if (i > 0) {
        fill(0, 0, 100);
      }
      else {
        fill(10, 100, 100);
      }
      drawText(String.format("%04x: %s", pc, dis), 0, 1+ i); 
    }
  }
}

