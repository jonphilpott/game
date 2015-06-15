 abstract class Eventable {
   ArrayList<EventListener> evListeners;
   int evSrcType;
 
   void evSetup(int t) {
     evListeners = new ArrayList<EventListener>();
     evSrcType = t;
   }
 
   void addListener(EventListener listener) {
     evListeners.add(listener);
   }
   
   void event(int a, int b) {
     for (int i = 0; i < evListeners.size(); i++) {
       evListeners.get(i).event(evSrcType, a, b);
     }
   }
 }
 
 interface EventListener {
   void event(int src, int a, int b);
 }
