class Memory {
  byte[] mem;
  int   size;
  
  
  Memory(int s) {
    mem  = new byte[s];
    size = s;
    for (int i = 0; i < s; i++) {
      mem[i] = (byte) i;
    }
  }

  byte get(int addr) {
    return mem[addr % size];
  }
  
  void set(int addr, byte val) {
    mem[addr % size] = val;
  }
  
  int getSize() {
    return size;
  }
}
