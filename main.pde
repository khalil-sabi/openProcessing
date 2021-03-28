import java.util.Collections;
import java.util.Comparator;
import java.lang.Math;
int N = 500;
ArrayList<Segment> segments = new ArrayList<Segment>();
ArrayList<Point> points = new ArrayList<Point>();
Segment chosen_one = null;

void setup() {
  size(500, 500);
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
  
  
  //diviser pour regner
 /*long startTime = System.nanoTime();
  Collections.sort(segments,new Comparaison());
  ArrayList<Segment> result = divideAndConquer(0,segments.size(),true);
  
  Collections.sort(result, new ComparaisonLongueur());
 
  if(result.size() != 0){
    chosen_one = result.get(result.size() - 1);
  }
  
  
  long endTime = System.nanoTime();
  println("temps d execution "+(endTime - startTime)/1000.0);
  */
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
  Boolean intersection = false;
  for (int i = debut;i < fin;i++) {
    intersection = false;
    Segment s = segments.get(i);
    for(int j = 0;j < segments.size();j++){
      if(j == i){continue;}
      Segment sj = segments.get(j);
      if( s.intersection(sj) ){
        intersection = true;
      }
    }
    if(!intersection){
      if(choisi == null){
        choisi = s;
      }else if(s.longueur() > choisi.longueur()){
        choisi = s;
      }
    }
  }
  long endTime = System.nanoTime();
  println("temps d execution "+(endTime - startTime)/1000.0);
  
  return choisi;
}

Segment sweepline(){
  long startTime = System.nanoTime();
  Boolean intersection;
  Collections.sort(points,new ComparaisonPoints());
  
  ArrayList<Segment> active = new ArrayList();
  ArrayList<Segment> candidats = new ArrayList();
  
  for (int i = 0;i < points.size();i++){
    Point pi = points.get(i);
    Segment si = pi.getSegment();
    intersection = false;
    if(pi == si.pointPlusHaut()){
      
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
          intersection= true;
          break;
        }
      }
      if(!intersection){
        candidats.add(si);
      }
      active.add(si);
    }else{
      active.remove(si);
    }
    
  }
  
  if(candidats.size() == 0){
    long endTime = System.nanoTime();
    println("temps d execution "+(endTime - startTime)/1000.0);
    return null;
  }else{
    Segment chosen = Collections.max(candidats,new ComparaisonLongueur());
    long endTime = System.nanoTime();
    println("temps d execution "+(endTime - startTime)/1000.0);
    return chosen;
  }
}



ArrayList<Segment> divideAndConquer(int start,int end,Boolean first){
  ArrayList<Segment> resultd,resultg, temp;
  
  if(end-start < 3){
    return bruteForceDivConq(start,end);
  }
  
  
  resultd = divideAndConquer(start, (start+end)/2,false);
  resultg = divideAndConquer((start+end)/2,end,false);
  
  if(first){
    temp = bruteForceDivConqTab(resultg,resultd);
    resultd = bruteForceDivConqTab(resultd,resultg);
    resultd.addAll(temp);
    return bruteForceDivConqTab(resultd,segments);
  }
  
  temp = bruteForceDivConqTab(resultg,resultd);
  resultd = bruteForceDivConqTab(resultd,resultg);
  resultd.addAll(temp);
  return resultd;
 
  
}

ArrayList<Segment> bruteForceDivConq(int start,int end){
  Boolean intersection = false;
  ArrayList<Segment> result = new ArrayList<Segment>();
  for(int i = start;i<end;i++){
      intersection = false;
      Segment si = segments.get(i);
      for(int j = 0;j < end;j++){
          Segment sj = segments.get(j);
          if(si == sj){continue;}
            if(si.intersection(sj) ){
              intersection = true;
              break;
            }
      }
      if(!intersection){
        result.add(si);
      }
    }
  
  return result;
}

ArrayList<Segment> bruteForceDivConqTab(ArrayList<Segment> a1, ArrayList<Segment> a2){
  Boolean intersection = false;
  ArrayList<Segment> result = new ArrayList<Segment>();
  for(int i = 0;i<a1.size();i++){
      intersection = false;
      Segment si = a1.get(i);
      for(int j = 0;j < a2.size();j++){
          Segment sj = a2.get(j);
          if(si == sj){continue;}
          
            if(si.intersection(sj) ){
              intersection = true;
              
            }
      }
      if(!intersection){
        result.add(si);
      }
    }
  return result;
}
