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
    
    //void createReflectBeam(LightBeam beam){
      //float m1 = Graph.findDerivative(beam.endx);
      //m1 = -(1/m1);
      //float m2 = beam.m;
      //if(m1 < 0){
      //  m2 = m1; 
      //  m1 = beam.m;
      //}
      //float m3 = (float) ((Math.pow(m1,2) * m2 + 2*m1 - m2) / (1 + 2*m1*m2 - Math.pow(m1,2)));
      //float b3 = beam.endy - m3 * beam.endx;
    //  float angle = atan(m3);
    //  if(m3 < 0){
    //   m3 = m3 * -1; 
    //  }
    //  beams.add(new LightBeam(beam.endx, beam.endy, angle));
    //  beams.get(beams.size() - 1).b = b3;
    //  beams.get(beams.size() - 1).endx = 2000;
    //  beams.get(beams.size() - 1).endy = 2000 * m3 + b3;
    //  beams.get(beams.size() - 1).bounced = true;
    //}
}