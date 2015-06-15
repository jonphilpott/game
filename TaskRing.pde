class TaskRing implements Tickable {
  ArrayList<Tickable> tickables;
  int idx;

  TaskRing() {
    tickables = new ArrayList<Tickable>();
    idx = 0;
  }

  void tick() {
    int s = tickables.size();
    if (s == 0) {
      return;
    }

    Tickable t = tickables.get(idx++ % s);
    t.tick();
  }

  void add(Tickable t) {
    tickables.add(t);
  }
}

class CPURing extends TaskRing {
  CPU add(Memory m, int pc) {
    CPU c = new CPU(m, pc);
    add(c);
    return c;
  }
}
