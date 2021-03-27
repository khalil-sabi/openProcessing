import java.util.Collections;
import java.util.Comparator;
import java.lang.Math;

int N = 200;
ArrayList<Segment> segments = new ArrayList<Segment>();
ArrayList<Point> points = new ArrayList<Point>();
Segment chosen_one = null;

void setup() {
  size(750, 750);
  for (int i = 0; i < N; i++) {
    Point p1 = new Point(random(width), random(height));
    Point p2 = new Point(random(width), random(height));
    Segment s = new Segment(p1,p2);
    p1.setSegment(s);
    p2.setSegment(s);
    segments.add(s);
    points.add(p1);
    points.add(p2);
  }
  
  //chosen_one = forceBrute(0,segments.size());
  //chosen_one = sweepline();
  long startTime = System.nanoTime();
  Collections.sort(segments,new Comparaison());
  
  chosen_one = divideAndConquer(0,segments.size(),null);
  
  long endTime = System.nanoTime();
  println((endTime - startTime)/1000.0);
  

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

Segment forceBrute(int debut, int fin){
  long startTime = System.nanoTime();
  Segment choisi = null;
  for (int i = debut;i < fin;i++) {
    Segment s = segments.get(i);
    Segment temp = s;
    for(int j = 0;j < segments.size();j++){
      if(j == i){continue;}
      Segment sj = segments.get(j);
      if( s.intersection(sj) ){
        temp = null;
      }
    }
    if(temp != null){
      if(choisi != null){
        if(temp.longueur() > choisi.longueur() ){
          choisi=temp;
        }
      }else{
        choisi = temp;
      }
    }
  }
    long endTime = System.nanoTime();
  println((endTime - startTime)/1000.0);
  
  return choisi;
}

Segment sweepline(){
  long startTime = System.nanoTime();
  Segment temp = null;
  Collections.sort(points,new ComparaisonPoints());
  
  ArrayList<Segment> active = new ArrayList();
  ArrayList<Segment> candidats = new ArrayList();
  
  for (int i = 0;i < points.size();i++){
    Point pi = points.get(i);
    Segment si = pi.getSegment();
    if(pi == si.pointPlusHaut()){
      temp = si;
      for(int j = 0;j< active.size();j++){
        Segment sj = active.get(j);
        if(si.intersection(sj)){
          candidats.remove(sj);
          for(int k = 0;k< candidats.size();k++){
            Segment sk = candidats.get(k);
            if(si.intersection(sk)){
              candidats.remove(sk);
            }
          }
          temp = null;
          break;
        }
      }
      if(temp != null){
        candidats.add(temp);
      }
      active.add(si);
    }else{
      active.remove(si);
    }
    
  }
  
  if(candidats.size() == 0){
    long endTime = System.nanoTime();
    println((endTime - startTime)/1000.0);
    return null;
  }else{
    Segment chosen = Collections.max(candidats,new ComparaisonLongueur());
    long endTime = System.nanoTime();
    println((endTime - startTime)/1000.0);
    return chosen;
  }
}


Segment divideAndConquer(int start,int end, Segment candidat){
  
  if(end-start < 3){
    for(int i = start;i<end;i++){
      if(candidat == null || segments.get(i).longueur()>candidat.longueur()){
        Segment temp = segments.get(i);
        for(int j = 0;j < segments.size();j++){
          if(j == i){continue;}
            Segment sj = segments.get(j);
              if(temp.intersection(sj) ){
                temp = null;
                break;
              }
          }
        if(temp != null){
          return temp;
        }
      }
    }
    return candidat;
  }
  
  
  Segment C1 = divideAndConquer(start, (start+end)/2, candidat);
  Segment C2 = divideAndConquer((start+end)/2, end, candidat);
  if(C1 == null && C2 == null){
    return null;
  }else if(C1 == null){return C2;}else if(C2 == null){return C1;}
  candidat = (C1.longueur() < C2.longueur()) ? C2 : C1;
  return candidat;
}
