public class LightBeam{
  float m;
  float b;
  float startx;
  float starty;
  float endx;
  float endy;
  float marchStep = 1;
 
  public LightBeam(float startPosX, float startPosY){
    startx = startPosX;
    starty = startPosY;
  }
  
  public void drawBeam(){
   line(startx, starty, endx, endy); 
  }
  
  public void findEndpoint(){
    
  }
     
}