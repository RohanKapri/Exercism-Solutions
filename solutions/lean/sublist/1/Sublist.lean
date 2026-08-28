namespace Sublist

inductive Classification where
  | sublist | superlist | equal | unequal
  deriving BEq, Repr

def isSublist {α} [BEq α] : List α → List α → Bool 
  | [], _  => true
  | _, []  => false
  | l₁, h :: t => l₁.isPrefixOf (h :: t) || isSublist l₁ t

def sublist (l₁ l₂ : List Nat) : Classification :=
  match isSublist l₁ l₂, isSublist l₂ l₁ with
  | true, true => .equal
  | true, _    => .sublist
  | _   , true => .superlist
  | _   , _    => .unequal

end Sublist