namespace Grains

def grains (square : Int) : Option Nat := do
  guard (1 <= square && square <= 64)
  1 <<< (square.toNat - 1)

def totalGrains : Nat :=
  (1 <<< 64) - 1

end Grains