class ParallelLightSource extends LightSource{
  float lightWidth = 150;
 
  public ParallelLightSource(float numberOfBeams, float xposition, float yposition){
    super(numberOfBeams, xposition, yposition);
  }
  
  @Override
  void createBeams(float numberOfBeams){
    numBeams = numberOfBeams;
    beams.clear();
    globalBeams.clear();
    float angle = 3 * PI / 2 + 0.01;
    for(int i = 0; i < numberOfBeams; i++){
      beams.add(new LightBeam(xpos + i * 31 , ypos, angle));
      beams.get(i).m = tan(angle);
      beams.get(i).b = beams.get(i).starty - (beams.get(i).m) * (beams.get(i).startx);
      beams.get(i).findEndpointAngular();
      globalBeams.add(beams.get(i));
    }
  }
  
  @Override
  void drawLightSource(){
    fill(0);
    rect(xpos, ypos, lightWidth, 30);
    fill(255);
  }
}