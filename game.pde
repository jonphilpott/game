
Memory myMem;
Hexview myHexview;

int keyIdx = 0;

void setup()
{
  size(800, 600);
  frameRate(24);

  myMem = new Memory(512);

  myHexview = new Hexview(myMem);
}

void draw() 
{
  myHexview.clearHilights();
  background(0);
  
  if (random(1000) < 5) {
    scale(1.05);
  }
  
  myHexview.setHilight(keyIdx, 1);
  myHexview.draw();
  

  
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
  }
  
  if (keyIdx < 0) {
    keyIdx = 0;
  }
}


