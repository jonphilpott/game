class CPUView {
  CPU cpu;
  float textWidth;
  float textHeight;
  float boxWidth;
  float boxHeight;
  Assembler asm;

  CPUView(CPU _cpu) {
    cpu = _cpu;
    textWidth = 1.1 * textWidth("#");
    textHeight = 1.5 * textWidth;
    boxHeight = 5 * textHeight;
    boxWidth  = 20 * textWidth;
    asm = new Assembler();
  }

  // draw text at x, y text units, not pixels
  void drawText(String text, int x, int y) {
    text(text, textWidth + (x * textWidth), textHeight + (y * textHeight));
  }

  void display() {
    noFill();
    stroke(0, 0, 100);
    rect(0, 0, boxWidth, boxHeight);
    drawText("*** CPU VIEW ***", 0, 0);

    drawText(String.format("A:  %02x", (short) cpu.a & 255), 0, 1);
    drawText(String.format("B:  %02x", (short) cpu.b & 255), 0, 2);
    drawText(String.format("PC: %04x", cpu.pc), 0, 3);
  }
}

