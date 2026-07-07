namespace PalindromeProducts

structure Factors where
  a : Nat
  b : Nat
  h : a ≤ b
  deriving BEq, Repr

structure Result where
  product : Nat
  factors : List Factors
  deriving BEq, Repr

private def isPalindrome (n : Nat) : Bool :=
  let reversed := Id.run do
    let mut value := n
    let mut acc := 0
    while value > 0 do
      acc := acc * 10 + value % 10
      value := value / 10
    pure acc
  n == reversed

private def mkFactors (x y : Nat) : Factors :=
  if h : x ≤ y then
    ⟨x, y, h⟩
  else
    ⟨y, x, Nat.le_of_lt (Nat.lt_of_not_ge h)⟩

private def smallestSearch (min max : Nat) : Option Result :=
  Id.run do
    let mut bestProduct : Option Nat := none
    let mut bestFactors : List Factors := []

    let mut a := min
    while a ≤ max do
      match bestProduct with
      | some current =>
          if a * a > current then
            a := max + 1
      | none =>
          pure ()

      if a ≤ max then
        let mut b := a
        while b ≤ max do
        let p := a * b

        match bestProduct with
        | some current =>
            if p > current then
              b := max + 1
        | none =>
            pure ()

        if b ≤ max && isPalindrome p then
          let factor : Factors := mkFactors a b
          match bestProduct with
          | none =>
              bestProduct := some p
              bestFactors := [factor]
          | some current =>
              if p < current then
                bestProduct := some p
                bestFactors := [factor]
              else if p == current then
                bestFactors := bestFactors.concat factor

        if b ≤ max then
          b := b + 1

      if a ≤ max then
        a := a + 1

    match bestProduct with
    | none => none
    | some product => some ⟨product, bestFactors⟩

private def largestSearch (min max : Nat) : Option Result :=
  Id.run do
    let mut bestProduct : Option Nat := none
    let mut bestFactors : List Factors := []

    let mut hi := max
    while min ≤ hi do
      match bestProduct with
      | some current =>
          if hi * hi < current then
            hi := 0
      | none =>
          pure ()

      if min ≤ hi then
        let mut lo := hi
        while min ≤ lo do
          let p := lo * hi

          match bestProduct with
          | some current =>
              if p < current then
                lo := 0
          | none =>
              pure ()

          if min ≤ lo && isPalindrome p then
            let factor : Factors := mkFactors lo hi
            match bestProduct with
            | none =>
                bestProduct := some p
                bestFactors := [factor]
            | some current =>
                if p > current then
                  bestProduct := some p
                  bestFactors := [factor]
                else if p == current then
                  bestFactors := bestFactors.concat factor

          if min ≤ lo then
            lo := lo - 1

      if min ≤ hi then
        hi := hi - 1

    match bestProduct with
    | none => none
    | some product => some ⟨product, bestFactors⟩

def smallest (min max : Nat) (_h₀ : min ≤ max) : Option Result :=
  smallestSearch min max

def largest (min max : Nat) (_h₀ : min ≤ max) : Option Result :=
  largestSearch min max

end PalindromeProducts