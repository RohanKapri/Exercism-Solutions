namespace IsbnVerifier

def toDigit (digit : Char) : Nat :=
  digit.toNat - '0'.toNat

def validate : Nat × Nat -> Char -> Option (Nat × Nat)
  | (0, _),  _    => none
  | (1, s), 'X'   => some (0, s + 10)
  | (m, s), '-'   => some (m, s)
  | (m + 1, s), v => do
    guard v.isDigit
    some (m, s + (m + 1) * toDigit v)

def isValid (isbn : String) : Bool :=
  match isbn.toList.foldlM validate (10, 0) with
  | some (0, s) => s % 11 == 0
  | _           => false

end IsbnVerifier