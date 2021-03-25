public class Point extends PVector{
  private Segment s;
  public Point (float x,float y){
    super(x,y);
  }
  public Point(float x,float y,Segment s){
    super(x,y);
    this.s = s;
  }
  public void setSegment(Segment s){
    this.s = s;
  }
  public Segment getSegment(){
    return s;
  }
}
