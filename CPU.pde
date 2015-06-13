class CPU {
  Memory mem;
  int pc;
  byte a, b;

  CPU(Memory m, int _pc) {
    mem = m;
    pc = _pc;
    a = 0;
    b = 0;
  }

  int tick() {
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

    pc = mem.normaliseAddr(newpc);
    return pc;
  }

  void display() {
    text(String.format("REGS: A %02X (%02d) B %02X (%02d) PC: %04X", (short) a, (short) a, (short) b, (short) b, pc), 0, 0);
  }
}

