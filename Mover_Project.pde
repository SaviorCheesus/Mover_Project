//Mover Project
import game2dai.entities.*;
import game2dai.entityshapes.ps.*;
import game2dai.maths.*;
import game2dai.*;
import game2dai.entityshapes.*;
import game2dai.fsm.*;
import game2dai.steering.*;
import game2dai.utils.*;
import game2dai.graph.*;

import java.util.*;

PVector vel = new PVector(50.0, 50.0);

World world;
StopWatch sw;
Vehicle mover;
BitmapPic view;
LinkedList<Vector2D> route = new LinkedList<Vector2D>();  

public void setup()  
{ 
  fullScreen(); 
  
  world = new World(width,height); 
  sw = new StopWatch(); 
  
  mover = new Vehicle( 
  new Vector2D(width/2, height/2), 
  30, 
  new Vector2D(100, 100), 
  100, 
  new Vector2D(50,50), 
  1, 
  10.0,   
  3000); 
    
  view = new BitmapPic(this, "SpriteSheet.png", 3, 1); 
  mover.renderer(view); 
   
  mover.AP().pathFactors(10, 1).pathOn(); 
  
  world.add(mover); 
  route.add(new Vector2D(mover.pos())); 
  
  sw.reset(); 
} 

public void draw()   
{ 
  double ellapsed = sw.getElapsedTime(); 
  world.update(ellapsed); 
   
  if (mover.AP().pathRouteLength() == 0) 
  { 
    mover.velocity(0, 0); 
  } 
   
  background(0); 
  
  Path(); 
  world.draw(ellapsed);  
}

void Path() 
{
  if (random(100) < 1) 
  {
    Vector2D wp = new Vector2D(random(-width/2, width *1.5), 
    random(-height/2, height*1.5));
    mover.AP().pathAddToRoute(wp);
    route.add(wp);
  }
  while (route.size () > mover.AP().pathRouteLength() + 1) 
  { 
    route.removeFirst(); 
  } 
}