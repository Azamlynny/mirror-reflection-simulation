public class Graph{

  float xstep = 1;
  int xmin = -400;
  int xmax = 400;

  List<Float> graph = new ArrayList<Float>();
  int graphWidth = 1;

  public Graph(){
    solveGraph();
  }

  void solveGraph(){
    float x = xmin;
    while(x < xmax){
      //graph.add((float) 50 * sin(x/20));
      graph.add(fx(x));
      x += xstep;
    }
  }
  
  float fx(float x){
     return (float) 0.02 * (float)  Math.pow(x, 2);
     //return (float) 50 * sin(x/20);
  }
  
  void drawGraph(){
    fill(0);
    stroke(0);
    for(int i = 1; i < Graph.graph.size(); i++){
      //ellipse((float) ((i-1)*xstep) , (float) (graph.get(i-1)), graphWidth, graphWidth); 
      line((i-1)*xstep + xmin, Graph.graph.get(i-1),(i)*xstep + xmin, Graph.graph.get(i));
    }
  }
  
  float findDerivative(float x){
     //return (5/2 * cos(x/20));
     return(0.04 * x);
  }
}