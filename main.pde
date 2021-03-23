import java.util.Collections;
import java.util.Comparator;
import java.lang.Math;

int N = 20;
ArrayList<Segment> segments = new ArrayList<Segment>();
Segment chosen_one = null;

void setup() {
  size(1000, 1000);

  for (int i = 0; i < N; i++) {
    segments.add(new Segment(new PVector(random(width), random(height)),new PVector(random(width), random(height))) );
  }
  
  forceBrute();
  strokeWeight(2);
  stroke(0);

  noLoop();
}

void draw() {
  background(255);
  strokeWeight(2);
  for (int i = 0;i < segments.size();i++){
    Segment s = segments.get(i);
    if(s == chosen_one){
      stroke(255,0,0);
    }else{
      stroke(0);
    }
    
    line(s.getP1().x,s.getP1().y,s.getP2().x,s.getP2().y);
  }

}

void forceBrute(){
for (int i = 0;i < segments.size();i++) {
    Segment s = segments.get(i);
    Segment temp = s;
    stroke(0);
    for(int j = 0;j < segments.size();j++){
      if(j == i){continue;}
      Segment sj = segments.get(j);
      if( s.intersection(sj) ){
        temp = null;
        break;
      }
    }
    if(temp != null){
      if(chosen_one != null){
        if(temp.longueur() > chosen_one.longueur() ){
          chosen_one=temp;
        }
      }else{
        chosen_one = temp;
      }
    }
  }
}
