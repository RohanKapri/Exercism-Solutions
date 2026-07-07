namespace PythagoreanTriplet

private structure Triplet where
  a : Nat
  b : Nat
  c : Nat

private def tripletLe (x y : Triplet) : Bool :=
  x.a < y.a || (x.a == y.a && (x.b < y.b || (x.b == y.b && x.c <= y.c)))

private def insertSorted (t : Triplet) : List Triplet → List Triplet
  | [] => [t]
  | x :: xs =>
      if tripletLe t x then
        t :: x :: xs
      else
        x :: insertSorted t xs

def tripletsWithSum (sum : Nat) : List (List Nat) :=
  if sum % 2 == 1 then
    []
  else
    let s := sum / 2
    let triples : List Triplet := Id.run do
      let mut acc : List Triplet := []
      let mut m := 2
      while m * m <= s do
        let mut n := 1
        while n < m do
          let d := m * (m + n)
          if s % d == 0 && Nat.gcd m n == 1 && (m + n) % 2 == 1 then
            let k := s / d
            let x := k * (m * m - n * n)
            let y := k * (2 * m * n)
            let a := Nat.min x y
            let b := Nat.max x y
            let c := k * (m * m + n * n)
            if a > 0 && a < b && b < c then
              acc := insertSorted { a := a, b := b, c := c } acc
          n := n + 1
        m := m + 1
      pure acc
    triples.map (fun t => [t.a, t.b, t.c])

end PythagoreanTriplet