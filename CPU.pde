class CPU extends Eventable implements Tickable {
  Memory mem;
  int pc;
  byte a, b;

  CPU(Memory m, int _pc) {
    mem = m;
    pc = _pc;
    a = 0;
    b = 0;
    this.evSetup(0);
  }

  void tick() {
    event(0, 0);
    int newpc = (pc + 2);
    byte op = mem.get(pc);
    byte t = 0;

    if (op == 0x0) {
      a = mem.get(pc + 1);
    }

    if (op == 0x1) {
      b = mem.get(pc + 1);
    }

    if (op == 0x2) {
      t = a;
      a = b;
      b = t;
    }

    if (op == 0x3) {
      newpc = pc + mem.get(pc + 1);
    }

    if (op == 0x4) {
      a = (byte)(a + b);
    }
    
    if (op == 0x5) {
      int dest_addr = pc + a;
      println("pc = " + pc + " a: " + a + " dest_addr = " + dest_addr) ;
      mem.set(dest_addr, b);
    }
    
    event(1, newpc);
    println("newpc = " + newpc);
    pc = mem.normaliseAddr(newpc);
  }
}

