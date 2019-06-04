import java.util.*;

float xstep = 2;
int xmin = -200;
int xmax = 200;
Graph Graph = new Graph();
LightSource source = new LightSource(10, 0, 300);

void setup(){
  frameRate(60);
  size(1960,1080);
}

void draw(){
  scale(1, -1);
  translate(width/2, -height/2);
  background(255);
  source.drawLightSource();
  source.drawLightBeams();
  Graph.drawGraph();
  moveSource();
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