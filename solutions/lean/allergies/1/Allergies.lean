namespace Allergies

inductive Allergen where
  | eggs | peanuts | shellfish | strawberries
  | tomatoes | chocolate | pollen | cats
  deriving BEq, Repr

def Allergen.toNat : Allergen -> Nat
  | .eggs          => 1 <<< 0
  | .peanuts       => 1 <<< 1
  | .shellfish     => 1 <<< 2
  | .strawberries  => 1 <<< 3
  | .tomatoes      => 1 <<< 4
  | .chocolate     => 1 <<< 5
  | .pollen        => 1 <<< 6
  | .cats          => 1 <<< 7

def allergicTo (allergen : Allergen) (score : Nat) : Bool :=
  score &&& allergen.toNat != 0

def list (score : Nat) : List Allergen :=
  [.eggs, .peanuts, .shellfish, .strawberries, .tomatoes, .chocolate, .pollen, .cats].filter (allergicTo · score)

end Allergies