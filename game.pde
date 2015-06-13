
Memory myMem;
Hexview myHexview;
CPU cpu1;
Assembler myAssembler;

int keyIdx = 0;

void setup()
{
  size(800, 600);
  frameRate(24);

  myMem = new Memory(128);
  cpu1 = new CPU(myMem, 0);
  myAssembler = new Assembler();
  myHexview = new Hexview(myMem);
}

void draw() 
{
  myHexview.clearHilights();
  background(0);

  int pc = cpu1.pc;
  myHexview.setHilight(keyIdx, 1);
  myHexview.setHilight(myMem.lastWriteAddr, 8);
  myHexview.setHilight(pc, 4);
  text(myAssembler.dis(myMem.get(pc), myMem.get(pc + 1)), 10, 20);
  pushMatrix();
  translate(200, 20);
  myHexview.draw();
  popMatrix();
  pushMatrix();
  translate(0, 600);
  cpu1.display();
  popMatrix();
}

void keyPressed() {
  if (key == CODED) {
    if (keyCode == LEFT) {
      keyIdx--;
    }
    if (keyCode == RIGHT) {
      keyIdx++;
    }
    if (keyCode == UP) {
      myMem.set(keyIdx, (byte)(myMem.get(keyIdx) + 1));
    }
    if (keyCode == DOWN) {
      myMem.set(keyIdx, (byte)(myMem.get(keyIdx) - 1));
    }
    if (keyCode == SHIFT) {
      cpu1.tick();
    }
  }

  if (keyIdx == -1) {
    keyIdx = myMem.getSize();
  }
}

