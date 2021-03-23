import java.util.Collections;
import java.util.Comparator;
import java.lang.Math;

int N = 100;
ArrayList<Segment> segments = new ArrayList<Segment>();

void setup() {
  size(1000, 1000);

  for (int i = 0; i < N; i++) {
    segments.add(new Segment(new PVector(random(width), random(height)),new PVector(random(width), random(height))) );
  }
  strokeWeight(2);
  stroke(0);

  noLoop();
}

void draw() {
  background(255);
  strokeWeight(2);
  
  Segment chosen_one = null;
  
  for (int i = 0;i < segments.size();i++) {
    Segment s = segments.get(i);
    stroke(0);
    for(int j = 0;j < segments.size();j++){
      if(j == i){continue;}
      Segment sj = segments.get(j);
      if( s.intersection(sj) ){
        stroke(255,0,0);
        break;
      }
    }
    line(s.getP1().x,s.getP1().y,s.getP2().x,s.getP2().y);
  }
}
