class Memory {
  byte[] mem;
  int   size;
  int   lastWriteAddr = 0;

  Memory(int s) {
    mem  = new byte[s];
    size = s;
    for (int i = 0; i < s; i++) {
      mem[i] = (byte) i;
    }
  }

  byte get(int addr) {
    addr = normaliseAddr(addr);
    return mem[addr];
  }

  void set(int addr, byte val) {
    println("mem: set addr: " + addr + " n: " + normaliseAddr(addr));

    addr = normaliseAddr(addr);
    lastWriteAddr = addr;
    mem[addr] = val;
  }

  int getSize() {
    return size;
  }

  int normaliseAddr(int addr) {
    if (addr < 0) {
      println("norm pre: " + addr);
      addr = (size + addr);
      println("norm post: " + addr);
    }


    return (addr % size);
  }
}

