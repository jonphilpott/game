import ddf.minim.*;
import ddf.minim.ugens.*;
import ddf.minim.effects.*;


Minim       minim;
AudioOutput out;
Oscil       wave, LFO;
Delay       delay;
IIRFilter filt;


Oscil voice1, voice2, voice3, voice4;

class SoundEngine implements EventListener {
  int[] eventRing;
  int   evPtr;
  

  SoundEngine() {
    // event Ring is big enough for 4 bars of 16 notes
    eventRing = new int[64];
    evPtr = 0;
  }
  
  void addSoundEvent(int offset, int flag) {
    eventRing[(evPtr + offset) % eventRing.length] = flag; 
  }
  
  void tick() {
    int ev = eventRing[evPtr];
    
    if (ev == 1) {
      voice1.patch(filt);
    }
    else {
      voice1.unpatch(filt);
    }
    
    eventRing[evPtr] = 0;
    evPtr = (evPtr + 1) % eventRing.length;
  }
  
  void setup() {
    minim = new Minim(this);
    out = minim.getLineOut();
    delay = new Delay(0.4, 0.5, true, true);

    LFO    = new Oscil( 0.2 , 500, Waves.SINE);
    LFO.offset.setLastValue(1000);
    


    voice1 = new Oscil( 440, 0.1f, Waves.QUARTERPULSE);
    voice2 = new Oscil( 220, 0.2f, Waves.SQUARE);
    voice3 = new Oscil( 110, 0.25f, Waves.SAW);
    voice4 = new Oscil( 55, 0.5f, Waves.SAW);


    filt = new LowPassFS(400, out.sampleRate());
    LFO.patch(filt.cutoff);
  
    filt.patch(delay).patch(out);
  }

  void eventOn(int voice) {
    if (voice == 0) {
      voice1.patch(filt);
    }
    if (voice == 1) {
      voice2.patch(filt);
    }
    if (voice == 2) {
      voice3.patch(filt);
    }
    if (voice == 3) {
      voice4.patch(filt);
    }
  }

  void eventOff(int voice) {
    if (voice == 0) {
      voice1.unpatch(filt);
    }
    if (voice == 1) {
      voice2.unpatch(filt);
    }
    if (voice == 2) {
      voice3.unpatch(filt);
    }
    if (voice == 3) {
      voice4.unpatch(filt);
    }
  }
  
  void event(int src, int a, int b) {
    println(String.format("Got event from %d (%d, %d)", src, a, b));
    addSoundEvent(0, 1);    
    addSoundEvent(1, 0);
  }
  
}

