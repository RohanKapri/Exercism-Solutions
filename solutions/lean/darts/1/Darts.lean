namespace Darts

inductive TargetRegion where
  | outside | outer 
  | middle  | inner  
  deriving BEq

def TargetRegion.score : TargetRegion -> Int
  | .outside => 0
  | .outer   => 1
  | .middle  => 5
  | .inner   => 10

def squaredDistance (x : Float) (y : Float) : Float :=
  x ^ 2 + y ^ 2

def distanceToRegion (d : Float) : TargetRegion :=
  if d > 100.0 then .outside
  else if d > 25.0 then .outer
  else if d > 1.0 then .middle
  else .inner

def score (x y : Float) : Int :=
  (distanceToRegion $ squaredDistance x y).score

end Darts