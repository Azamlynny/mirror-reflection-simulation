import java.util.*;

float xstep = 2;
List<Float> graph = new ArrayList<Float>();
int xmin = -200;
int xmax = 200;
int graphWidth = 1;
LightSource source = new LightSource(10, 0, 300);

void setup(){
  frameRate(60);
  size(1960,1080);
  solveGraph();
}

void draw(){
  scale(1, -1);
  translate(width/2, -height/2);
  background(255);
  source.drawLightSource();
  source.drawLightBeams();
  drawGraph();
  moveSource();
}

void solveGraph(){
  float x = xmin;
  while(x < xmax){
    graph.add((float) 50 * sin(x/20));
    x += xstep;
  }
}

void drawGraph(){
  fill(0);
  stroke(0);
  for(int i = 1; i < graph.size(); i++){
    //ellipse((float) ((i-1)*xstep) , (float) (graph.get(i-1)), graphWidth, graphWidth); 
    line((i-1)*xstep, graph.get(i-1),(i)*xstep, graph.get(i));
  }
}

void mousePressed(){
  float x = mouseX - width/2;
  float y = -mouseY + height/2;
  if(Math.abs(x - source.xpos) < 45 || Math.abs(y - source.ypos) < 45){
     source.moving = true;
  }
}

void mouseReleased(){  
  float x = mouseX - width/2;
  float y = -mouseY + height/2;
  if(source.moving){
    source.moving = false; 
    source.xpos = x;
    source.ypos = y;
    source.createBeams(source.numBeams);
  }
}

void moveSource(){
  float x = mouseX - width/2;
  float y = -mouseY + height/2;
  if(source.moving){
    source.xpos = x;
    source.ypos = y;
    source.createBeams(source.numBeams);
  }
}

void mouseWheel(MouseEvent event) {
  float e = event.getCount();
  if(e == 1){
    source.numBeams--;
    source.createBeams(source.numBeams);
  }
  else if (e==-1){
    source.numBeams++; 
    source.createBeams(source.numBeams);
  }
}