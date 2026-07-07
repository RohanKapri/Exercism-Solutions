namespace DifferenceOfSquares

/-
  This exercise is a fine opportunity to practice proofs in Lean:

  * Both functions have well-known formulas that can be proved using straightforward inductive reasoning.
  * However, a naive implementation is often clearer and more self-documenting.

  In this case, a common pattern in Lean is:

  1. Define a simple and readable public-facing function.
  2. Define an equivalent but more efficient implementation.
  3. Prove that the two implementations are equal, annotating it with the compiler attribute `csimp`.

  Using `csimp`, the compiler substitutes the simple implementation with the efficient one at runtime.
  This is the best of the two worlds: better documentation and efficient implementation.

  Many `List` and `Array` functions follow this pattern.
  They have a clear specification function, which is replaced during compilation with a more efficient tail-recursive one.
-/

def sumN' (n : Nat) : Nat := (n * (n + 1)) / 2

def sumN : Nat → Nat
  | 0     => 0
  | n + 1 => (n + 1) + sumN n

@[csimp]
theorem sumN_eq_sumN' : sumN = sumN' := by
  funext n
  induction n with
  | zero      => simp [sumN, sumN']
  | succ i ih =>
    simp [sumN, sumN', ih]
    grind

def squareOfSum (number : Nat) : Nat :=
  sumN number ^ 2

def sumOfSquares' (n : Nat) : Nat := (n * (n + 1) * (2*n + 1)) / 6

def sumOfSquares : Nat → Nat
  | 0     => 0
  | n + 1 => (n + 1) * (n + 1) + sumOfSquares n

@[csimp]
theorem sumOfSquares_eq_sumOfSquares' : sumOfSquares = sumOfSquares' := by
  funext n
  induction n with
  | zero => simp [sumOfSquares, sumOfSquares']
  | succ i ih =>
    simp [sumOfSquares, sumOfSquares', ih]
    grind

def differenceOfSquares (number : Nat) : Nat :=
  squareOfSum number - sumOfSquares number

end DifferenceOfSquares