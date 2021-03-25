public class Segment{
  private PVector p1;
  private PVector p2;
  
  public Segment(PVector p1, PVector p2){
    this.p1 = p1;
    this.p2 = p2;
  }
  public PVector getP1(){return p1;}
  public PVector getP2(){return p2;}
  
  public float longueur(){
    return sqrt( pow(p1.x-p2.x,2) + pow(p1.y-p2.y,2)  );
  }
  
  public PVector pointPlusBas(){
    if(p1.y<p2.y){
      return p2;
    }else{
      return p1;
    }
  }
  
  public PVector pointPlusHaut(){
    if(p1.y<p2.y){
      return p1;
    }else{
      return p2;
    }
  }

  
  
  
  public Boolean croiseSegment(PVector p, PVector q, PVector r){
    if (q.x <= max(p.x, r.x) && q.x >= min(p.x, r.x) && q.y <= max(p.y, r.y) && q.y >= min(p.y, r.y)){
          return true;
        }
    return false;
  }
 
  public Boolean croiseSegment(PVector p){
     if( p.x <= max(p1.x,p2.x) && p.x>=min(p1.x,p2.x) && p.y <= max(p1.y,p2.y) && p.x>=min(p1.y,p2.y) ){
       return true;
     }
    return false;
  }
  
  public int orientation(PVector p){
    float v = ((p.y - p1.y) * (p2.x - p.x) - (p.x - p1.x) * (p2.y - p.y));
    
    if(v == 0.0){ return 0; }
    else if(v > 0.0){ return 1; }
    else{ return 2; }
  }
  public Boolean intersection(Segment s){
    int o1 = this.orientation(s.getP1()), o2= this.orientation(s.getP2()), o3 = s.orientation(p1), o4 = s.orientation(p2);
    if(o1 != o2 && o3 != o4){
      return true;
    }
    if( o1 == 0.0 && this.croiseSegment(p1,s.getP1(),p2)){
      return true;
    }
    
    if( o2 == 0.0 && this.croiseSegment(p1,s.getP2(),p2)){
      return true;
    }
    
    if( o3 == 0.0 && this.croiseSegment(s.getP1(),p1,s.getP2())){
      return true;
    }
    
    if( o4 == 0.0 && this.croiseSegment(s.getP1(),p2,s.getP2())){
      return true;
    }
    
    return false;
  }
  
}
