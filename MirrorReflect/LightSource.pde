public class LightSource{
  float numBeams;
  float xpos;
  float ypos;
  List<LightBeam> beams;
  boolean moving = false;

    public LightSource(float numberOfBeams, float xposition, float yposition){
      numBeams = numberOfBeams;
      xpos = xposition;
      ypos = yposition;
      beams = new ArrayList<LightBeam>();
      createBeams(numBeams);    
    }
    
    void createBeams(float numberOfBeams){
      numBeams = numberOfBeams;
      beams.clear();
      globalBeams.clear();
      float angleBetween = (2 * PI) / numBeams;
   
      for(int i = 0; i < numBeams; i++){
         beams.add(new LightBeam(xpos, ypos, angleBetween * i));
         beams.get(i).m = tan(angleBetween * i);
         beams.get(i).b = beams.get(i).starty - (beams.get(i).m) * (beams.get(i).startx);
         beams.get(i).findEndpointAngular();
         globalBeams.add(beams.get(i));
      }
    }
    
    void drawLightSource(){
       fill(255, 255, 0);
       ellipse(xpos, ypos, 45, 45);
       fill(255);
    }
   
}