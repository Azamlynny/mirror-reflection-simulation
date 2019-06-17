public class Graph{

  float xstep = 1;
  int xmin = -200;
  int xmax = 200;

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
     //return((float) (0.00007 * Math.pow(x,3) + 0.01 * Math.pow(x,2) - x) - 200);//\frac{1}{10000}x^3+\frac{1}{100}x^2-x
     //return(2 * x);
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
    return(0.04 * x);
    //return (5/2 * cos(x/20));
    //return((float)(0.00021 * Math.pow(x,2) + 0.02 * x - 1));
    //return(2);  
  }
}