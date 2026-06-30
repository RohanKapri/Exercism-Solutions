import Std

namespace CustomSet

structure Set where
  elems : List Nat
  lookup : Std.HashSet Nat
deriving Repr

namespace Set

instance : Membership Nat Set where
  mem (s : Set) (n : Nat) := s.lookup.contains n = true

instance (s : Set) (n : Nat) : Decidable (n ∈ s) := by
  show Decidable (s.lookup.contains n = true)
  infer_instance

instance : EmptyCollection Set where
  emptyCollection := ⟨[], {}⟩

def subset (a b : Set) : Prop :=
  a.elems.all (fun x => decide (x ∈ b)) = true

instance : HasSubset Set where
  Subset := subset

instance (a b : Set) : Decidable (a ⊆ b) := by
  show Decidable (a.elems.all (fun x => decide (x ∈ b)) = true)
  infer_instance

instance : BEq Set where
  beq a b := decide (a ⊆ b) && decide (b ⊆ a)

def add (s : Set) (n : Nat) : Set :=
  if s.lookup.contains n then
    s
  else
    ⟨s.elems ++ [n], s.lookup.insert n⟩

def ofList : List Nat -> Set
  | [] => ∅
  | x :: xs => (ofList xs).add x

def inter (a b : Set) : Set :=
  (a.elems.filter (fun x => decide (x ∈ b))).foldl (fun acc n => acc.add n) ∅

def union (a b : Set) : Set :=
  b.elems.foldl (fun acc x => acc.add x) a

def sdiff (a b : Set) : Set :=
  (a.elems.filter (fun x => decide (x ∉ b))).foldl (fun acc n => acc.add n) ∅

def disjoint (a b : Set) : Bool :=
  a.elems.all (fun x => decide (x ∉ b))

instance : Inter Set where
  inter := inter

instance : Union Set where
  union := union

instance : SDiff Set where
  sdiff := sdiff

end Set

notation:50 a " ⊈ " b => ¬ (a ⊆ b)

end CustomSet