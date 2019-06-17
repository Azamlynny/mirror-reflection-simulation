import java.util.*;

int lightBeams = 10;

Graph Graph = new Graph();
List<LightBeam> globalBeams = new ArrayList<LightBeam>();
LightSource source = new LightSource(lightBeams, 0, 300);
//LightSource source = new ParallelLightSource(5,-500,300);

void setup(){
  frameRate(60);
  size(1960,1080);
}

void draw(){
  scale(1, -1);
  translate(width/2, -height/2);
  background(255);
  source.drawLightSource();
  drawLightBeams();
  Graph.drawGraph();
  moveSource();
  fill(0);
  ellipse(0,0,5,5); // origin
  drawNorms();
  drawInfo();
}

void drawNorms(){
  //draw tangents etc normals
  if(key == 32 || key != ENTER && key != 0){
    for(int i = 0; i < globalBeams.size(); i++){
      if(globalBeams.get(i).n1m != 0){  
        stroke(100, 204, 252);
        line(-1000, globalBeams.get(i).n1m * -1000 + globalBeams.get(i).n1b, 1000, globalBeams.get(i).n1m * 1000 + globalBeams.get(i).n1b); 
        stroke(0);
      }
    }
  }
  if(key == ENTER || key != 32 && key != 0){
    for(int i = 0; i < globalBeams.size(); i++){
      if(globalBeams.get(i).n2m != 0){  
        stroke(112, 249, 160);
        line(-1000, globalBeams.get(i).n2m * -1000 + globalBeams.get(i).n2b, 1000, globalBeams.get(i).n2m * 1000 + globalBeams.get(i).n2b); 
        stroke(0);
      }
    }
  }
  if(key == 'c'){
  }
}

void mouseWheel(MouseEvent event) {
  float e = event.getCount();
  if(e == 1){
    source.createBeams(source.numBeams - 1);
  }
  if(e == -1){
    source.createBeams(source.numBeams + 1);
  }
}

void mousePressed(){
  float x = mouseX - width/2;
  float y = -mouseY + height/2;
  if(Math.abs(x - source.xpos) < 45 || Math.abs(y - source.ypos) < 45){
     source.moving = true;
  }
}

void keyReleased(){
  key = 0; 
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

void drawLightBeams(){
  strokeWeight(3);
  stroke(255,255,0);
  for(int i = 0; i < globalBeams.size(); i++){
    globalBeams.get(i).drawBeam(); 
  }
  stroke(0);
  strokeWeight(1); 
}

void drawInfo(){
  pushMatrix();
  scale(1, -1);
  translate(-width/2, -height/2);
  textSize(20);
  text("Press SPACE to see tangents", 50 , 25);
  text("Press ENTER to see normals", 50 , 50);
  text("Press any key to see tangents and normals", 50 , 75);
  text("Number of Light Rays: " + (int) source.numBeams, 50 , 150);
  int reflections = 0;
  for(int i = 0; i < globalBeams.size(); i++){
    if(globalBeams.get(i).bounced){
      reflections++; 
    }
  }
  text("Number of Reflections: " + reflections, 50 , 175);
  popMatrix();
}