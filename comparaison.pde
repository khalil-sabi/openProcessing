public class Comparaison implements Comparator<Segment>{
  public int compare(Segment s1,Segment s2){
    if( s1.pointPlusHaut().y<s2.pointPlusHaut().y ){
      return -1;
    }else if( s1.pointPlusHaut().y>s2.pointPlusHaut().y ){
      return 1;
    }else{
      return 0;
    }
  }
}

public class ComparaisonLongueur implements Comparator<Segment>{
  public int compare(Segment s1,Segment s2){
    if( s1.longueur()<s2.longueur() ){
      return 1;
    }else if( s1.longueur()>s2.longueur() ){
      return -1;
    }else{
      return 0;
    }
  }
}

public class ComparaisonPoints implements Comparator<Point>{
  public int compare(Point p1,Point p2){
    if(p1.y<p2.y){
      return -1;
    }else if(p2.y<p1.y){
      return 1;
    }else{
      return 0;
    }
  }
}
