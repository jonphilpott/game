class MSGAgent implements Tickable {
  Memory mem;
  int addr;
  String msg;
  int idx;
  
  MSGAgent(Memory _mem, int _addr, String _msg) {
    mem = _mem;
    addr = _addr;
    msg = _msg;
    idx = 0;
  }
  
  void tick() {
    char c = msg.charAt(idx);
    mem.set(addr + idx, (byte) c);
    idx = (idx + 1) % msg.length();
  }
}
