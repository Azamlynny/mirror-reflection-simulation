public class LightBeam{
  float m;
  float b; 
  float startx;
  float starty;
  float endx;
  float endy;
  float angle;
  float marchStep = 0.5;
  float errorMargin = 4;
  float ignoreErrorMargin = 3;
  boolean reflected = false;
  boolean bounced = false;
  int graphIndex;
  float leniency = 15;
  int recursions = 2;
  boolean first = false;
  String marchRule = "add";
  float marchXStep = 0;
  float marchYStep = 0;
  float lastX;
  float lastY;
  float n1m;
  float n1b;
  float n2m;
  float n2b;
  boolean doRecursion = false; 
  
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
    first = true;
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
          graphIndex = g;
          break;
        }
      }
      if(Math.abs(x) > 1000 || Math.abs(y) > 1000){
        break; 
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
  
  public void findEndpointLinear(int recursion, LightBeam beam){
    boolean intersect = false;
    float maxLength = (2000) * m + startx;
    float maxHeight = (2000) * m + starty;
    float x = startx + errorMargin * ignoreErrorMargin;
    float y = starty + m * errorMargin * ignoreErrorMargin;
    float backTrackX = 0;
    float backTrackY = 0;
      
    backTrackX = beam.endx - marchStep * cos(beam.angle);
    backTrackY = beam.endy - marchStep * sin(beam.angle);
    
    float graphX = Graph.fx(backTrackX);
    String direction = "";
    if(backTrackY < graphX){
      direction = "below"; 
    }
    else if(backTrackY > graphX){
      direction = "above"; 
    }
    String rule = "";
    if(direction.equals("below") && starty + marchXStep * m < Graph.fx(startx + marchStep * 1)){
      rule = "add";
    }
    else if(direction.equals("below")){
      rule = "subtract"; 
    }
    if(direction.equals("above") && starty - marchStep * m < Graph.fx(startx - marchStep * 1)){
      rule = "add";
    }
    else if(direction.equals("above")){
      rule = "subtract"; 
    }
    marchRule = rule;
    float maxX;
    float maxY;
    if(rule.equals("add")){
      maxX = 1000;
      maxY = 1000 * m + b;
    }
    else if(rule.equals("subtract")){
      maxX = -1000;
      maxY = -1000 * m + b;
    }
    else{ // Might change
      maxX = 1000;
      maxY = 1000 * m + b;
    }
    
    float steps = (Math.abs(maxX - startx));
    float xstep = (maxX - startx)/steps;
    float ystep = (maxY - starty)/steps;
    marchXStep = xstep;
    marchYStep = ystep;
     x += leniency * xstep * errorMargin;
     y += leniency * ystep * errorMargin;
      
    //logic to check for intersections
    while(intersect == false){
      x += xstep;
      y += ystep;
      for(int g = 0; g < Graph.graph.size(); g++){
        if(distance(x, y, (float) g * Graph.xstep + Graph.xmin, (float) Graph.graph.get(g)) < errorMargin + 3){
          intersect = true;
          reflected = true; 
          lastX = x - marchStep;
          lastY = y - ystep * marchStep;
          x = g * Graph.xstep + Graph.xmin;
          y = Graph.graph.get(g);
          graphIndex = g;
          break;
        }
      }
      if(distance(x,y,maxX,maxY) < 3){
        break; 
      }
      if(Math.abs(x) > 1000 || Math.abs(y) > 1000){
        break; 
      }
    }
    
    if(intersect == true){
      endx = x;
      endy = y;
      if(doRecursion){
        createReflection(recursion++);
      }  
    }
    else if(intersect == false){
      endx = maxX;
      endy = maxY;
    }
  }
  
  public void createReflection(int recursion){
    if(recursion < recursions){
      float m1 = Graph.findDerivative(this.endx);
      n1b = this.endy - m1 * this.endx;
      n1m = m1;
      m1 = -(1/m1);
      n2m = m1;
      n2b = this.endy - m1 * this.endx;;
      float m2 = this.m;
      float m3 = (float) ((Math.pow(m1,2) * m2 + 2*m1 - m2) / (1 + 2*m1*m2 - Math.pow(m1,2)));
      float b3 = this.endy - m3 * this.endx;
      
      globalBeams.add(new LightBeam(this.endx, this.endy, m3, b3));
      globalBeams.get(globalBeams.size() - 1).bounced = true;
      globalBeams.get(globalBeams.size() - 1).findEndpointLinear(recursion, this);
    }  
  }
  
  public double distance(float x1, float y1, float x2, float y2){
     return Math.sqrt(Math.pow(x2-x1,2) + Math.pow(y2-y1,2));
  }
  
}