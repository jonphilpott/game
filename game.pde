
Memory myMem;
Hexview myHexview;
DisassemblerView myDisView;
CPUView myCPUView1, myCPUView2;
CPU cpu1, cpu2;
Assembler myAssembler;
CPURing myCPURing;
MSGAgent cheeseAgent, goatAgent;
PFont font;

int keyIdx = 0;

void setup()
{
  size(800, 600);

  // only one font used here.
  font = createFont("Consolas Bold", 12);
  textFont(font);
  colorMode(HSB, 100);

  myMem = new Memory(512);

  myCPURing = new CPURing();

  cpu1 = myCPURing.add(myMem, 0);
  cpu2 = myCPURing.add(myMem, 128);

  TaskRing tr = new TaskRing();
  cheeseAgent = new MSGAgent(myMem, 64, "CHEESE PLEASE");
  goatAgent = new MSGAgent(myMem, 96, "GOATS GOATS GOATS GOATS GOATS GOATS");
  tr.add(cheeseAgent);
  tr.add(goatAgent);

  myCPURing.add(tr);

  myCPUView1 = new CPUView(cpu1);
  myCPUView2 = new CPUView(cpu2);

  myAssembler = new Assembler();
  myHexview = new Hexview(myMem);
  myDisView = new DisassemblerView(myMem, 10);

}

int deltaS = -1;
int S = 0;
int t = 0;
int lwa = 0;

void draw() 
{
  update();

  S = millis()/500;
  if (deltaS != S) {
    myCPURing.tick();
    deltaS = S;
  }
}

void update() {
  myHexview.clearHilights();
  background(0);

  myHexview.setHilight(keyIdx, 2);
  myHexview.setHilight(cpu1.pc, 5);
  myHexview.setHilight(cpu2.pc, 7);
  myHexview.setHilight(myMem.lastWriteAddr, 9);

  myDisView.setLoc(keyIdx);

  pushMatrix();
  translate(10, 10);
  myDisView.display();
  popMatrix();

  pushMatrix();
  translate(10, 20 + myDisView.boxHeight);
  myCPUView1.display();
  popMatrix();

  pushMatrix();
  translate(10, 30 + myDisView.boxHeight + myCPUView1.boxHeight);
  myCPUView2.display();
  popMatrix();


  pushMatrix();
  translate(width - myHexview.boxWidth - 10, 10);
  myHexview.draw();
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

