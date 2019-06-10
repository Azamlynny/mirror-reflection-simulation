public class LightBeam{
  float m;
  float b; 
  float startx;
  float starty;
  float endx;
  float endy;
  float angle;
  float marchStep = 0.5;
  float errorMargin = 3;
  boolean reflected = false;
  boolean bounced = false;
 
  public LightBeam(float startPosX, float startPosY, float ang){
    startx = startPosX;
    starty = startPosY;
    angle = ang;
    //errorMargin = Graph.xstep;
  }
  
  public LightBeam(float startPosX, float startPosY, float slope, float yintercept){
    startx = startPosX;
    starty = startPosY;
    errorMargin = Graph.xstep;
    m = slope;
    b = yintercept;
  }
  
  public void drawBeam(){
   if(bounced){
     stroke(0,0,255); 
   }
   else{
     stroke(255,255,0);
   }
   line(startx, starty, endx, endy); 
  }
  
  public void findEndpointAngular(){
    boolean intersect = false;
    float maxLength = (2000) * cos(angle) + startx;
    float maxHeight = (2000) * sin(angle) + starty;
    float x = startx;
    float y = starty;
    
    while(Math.abs(x) < 2000 && intersect == false){
      x += marchStep * cos(angle);
      y += marchStep * sin(angle);
      for(int g = 0; g < Graph.graph.size(); g++){
        if(distance(x, y, (float) g * Graph.xstep + Graph.xmin, (float) Graph.graph.get(g)) < errorMargin){
          intersect = true;
          reflected = true; 
          x = g * Graph.xstep + Graph.xmin;
          y = Graph.graph.get(g);
          break;
        }
      }
    }
    
    if(intersect == true){
      endx = x;
      endy = y;
      createReflection(1);
    }
    else if(intersect == false){
      endx = maxLength;
      endy = maxHeight;
    }  
  }
  
  public void findEndpointLinear(int recursion){
    boolean intersect = false;
    float maxLength = (2000) * m + startx;
    float maxHeight = (2000) * m + starty;
    float x = startx;
    float y = starty;
    
    while(Math.abs(x) < 2000 && intersect == false){
      x += marchStep * 1;
      y += marchStep * m;
      for(int g = 0; g < Graph.graph.size(); g++){
        if(distance(x, y, (float) g * Graph.xstep + Graph.xmin, (float) Graph.graph.get(g)) < errorMargin){
          intersect = true;
          reflected = true; 
          x = g * Graph.xstep + Graph.xmin;
          y = Graph.graph.get(g);
          break;
        }
      }
    } 
     
    if(intersect == true){
      endx = x;
      endy = y;
      //createReflection(recursion++);
    }
    else if(intersect == false){
      endx = maxLength;
      endy = maxHeight;
    }    
  }
  
  public void createReflection(int recursion){
    if(recursion < 3){
      float m1 = Graph.findDerivative(this.endx);
      m1 = -(1/m1);
      float m2 = this.m;
      if(m1 < 0){
        m2 = m1; 
        m1 = this.m;
      }
      float m3 = (float) ((Math.pow(m1,2) * m2 + 2*m1 - m2) / (1 + 2*m1*m2 - Math.pow(m1,2)));
      float b3 = this.endy - m3 * this.endx;
      globalBeams.add(new LightBeam(this.endx, this.endy, m3, b3));
      globalBeams.get(globalBeams.size() - 1).findEndpointLinear(recursion++);
    }  
  }
  
  public double distance(float x1, float y1, float x2, float y2){
     return Math.sqrt(Math.pow(x2-x1,2) + Math.pow(y2-y1,2));
  }
  
}