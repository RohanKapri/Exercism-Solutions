namespace NucleotideCount

inductive Nucleotide where
  | A | C | G | T

structure NucleotideMap where
  a : Nat
  c : Nat
  g : Nat
  t : Nat
  deriving Repr

instance : GetElem NucleotideMap Nucleotide Nat (fun _ _ => True) where
  getElem m n _ := match n with
    | .A => m.a
    | .C => m.c
    | .G => m.g
    | .T => m.t

def nucleotideCounts (s : String) : Option NucleotideMap :=
  s.foldl (fun acc c =>
    match acc with
    | none => none
    | some m =>
      match c with
      | 'A' => some { m with a := m.a + 1 }
      | 'C' => some { m with c := m.c + 1 }
      | 'G' => some { m with g := m.g + 1 }
      | 'T' => some { m with t := m.t + 1 }
      | _   => none)
    (some { a := 0, c := 0, g := 0, t := 0 })

end NucleotideCount