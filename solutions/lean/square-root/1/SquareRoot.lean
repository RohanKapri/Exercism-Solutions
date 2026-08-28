namespace SquareRoot

def babylonianRoot (radicand guess : Float) : Nat -> Float
  | 0        => guess
  | fuel + 1 =>
     let newGuess := (guess + radicand / guess) / 2
     babylonianRoot radicand newGuess fuel

def squareRoot (radicand : Nat) : Nat :=
  let root := babylonianRoot radicand.toFloat 1.0 10
  root.toUInt64.toNat

end SquareRoot