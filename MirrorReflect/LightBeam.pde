public class LightBeam{
  float m;
  float b;
  float startx;
  float starty;
  float endx;
  float endy;
  float angle;
  float marchStep = 0.5;
  float errorMargin = 1;
 
  public LightBeam(float startPosX, float startPosY, float ang){
    startx = startPosX;
    starty = startPosY;
    angle = ang;
  }
  
  public void drawBeam(){
   line(startx, starty, endx, endy); 
  }
  
  public void findEndpoint(LightSource source, int i){ // i = index
    boolean intersect = false;
    float maxLength = (2000) * cos(angle) + source.beams.get(i).startx;
    float maxHeight = (2000) * sin(angle) + source.beams.get(i).starty;
    float x = startx;
    float y = starty;
    for(int g = 0; g < Graph.graph.size(); g++){
      x = startx;
      y = starty;
      while(Math.abs(x) < maxLength && intersect == false){
        if(distance(x, y, (float) g, (float) Graph.graph.get(g)) < errorMargin){
          intersect = true;
          x = g;
          y = Graph.graph.get(g);
        }
        else{
          x += 1 * marchStep;
          y += m * marchStep;
        }
      }
      if(intersect){
        break;
      }
    }
    
    if(intersect == true){
      source.beams.get(i).endx = x;
      source.beams.get(i).endy = y;
    }
    else if(intersect == false){
      source.beams.get(i).endx = maxLength;
      source.beams.get(i).endy = maxHeight;
    }  
  }
     
  public double distance(float x1, float y1, float x2, float y2){
     return Math.sqrt(Math.pow(x2-x1,2) + Math.pow(y2-y1,2));
  }
  
}