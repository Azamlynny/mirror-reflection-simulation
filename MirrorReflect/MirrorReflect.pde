import java.util.*;

float xstep = 0.01;
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
  for(int i = 1; i < graph.size(); i++){
    ellipse((float) ((i-1)*xstep) , (float) (graph.get(i-1)), graphWidth, graphWidth); 
  }
}