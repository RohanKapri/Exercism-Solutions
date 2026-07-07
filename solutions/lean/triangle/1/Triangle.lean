namespace Triangle

def isValid : List Float -> Bool
  | [a, b, c] => a > 0 && b > 0 && c > 0 && a + b >= c && a + c >= b && b + c >= a
  | _ => false

def kind (sides : List Float) : Nat :=
  sides.eraseDups.length

def equilateral (sides : List Float) : Bool :=
  isValid sides && kind sides == 1

def isosceles (sides : List Float) : Bool :=
  isValid sides && kind sides <= 2

def scalene (sides : List Float) : Bool :=
  isValid sides && kind sides == 3

end Triangle