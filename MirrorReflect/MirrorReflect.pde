import java.util.*;

float xstep = 0.01;
List<Float> graph = new ArrayList<Float>();
int xmin = -200;
int xmax = 200;

void setup(){
  frameRate(60);
  size(1960,1080);
  solveGraph();
}

void draw(){
  scale(1, -1);
  translate(width/2, -height/2);
  background(255);
  drawGraph();
}

void solveGraph(){
  float x = xmin;
  while(x < xmax){
    graph.add((float) 50 * sin(x/100));
    x += xstep;
  }
}

void drawGraph(){
  fill(0);
  for(int i = 1; i < graph.size(); i++){
    rect((float) ((i-1)*xstep) , (float) (graph.get(i-1)), 5, 5); 
  }
}