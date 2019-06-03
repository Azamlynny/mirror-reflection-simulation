public class LightSource{
  float numBeams;
  float xpos;
  float ypos;
  List<LightBeam> beams;

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
      
      float angleBetween = (2 * PI) / numBeams;
      for(int i = 0; i < numBeams; i++){
         beams.add(new LightBeam(xpos, ypos));
         beams.get(i).m = tan(angleBetween * i);
         beams.get(i).startx = xpos;
         beams.get(i).starty = ypos;
         beams.get(i).b = beams.get(i).starty - (beams.get(i).m) * (beams.get(i).startx);
         beams.get(i).endx = 1000 * cos(angleBetween * i);
         beams.get(i).endy = 1000 * sin(angleBetween * i);
      }
    }
      
    void drawLightSource(){
       fill(255, 255, 0);
       ellipse(xpos, ypos, 45, 45);
       fill(255);
    }
    
    void drawLightBeams(){
      strokeWeight(3);
      stroke(255,255,0);
      for(int i = 0; i < beams.size(); i++){
        line(beams.get(i).startx, beams.get(i).starty, beams.get(i).endx, beams.get(i).endy); 
      }
      stroke(0);
      strokeWeight(1);
    }
}