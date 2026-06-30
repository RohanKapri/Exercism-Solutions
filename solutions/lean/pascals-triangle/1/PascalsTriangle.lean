namespace PascalsTriangle

/-
  Define here a type `Triangle`.
  Instances of this type are generated wrapped in a suitable monad, through a `mkTriangle` function.

  There must be syntax defined for a `triangle(n)`, where `triangle` is an instance of `Triangle` and `n` is a `Nat`.
  This syntax should return the `n-th` row of a Pascal's Triangle as an `Array Nat`, wrapped in a suitable monad.

  Try to make your implementation as efficient as possible.
  There are tests for larger rows that may time out.

  Refer to the test file for more information.
-/

abbrev TriangleM := IO

def mkRowBinomial (n : Nat) : Array Nat := Id.run do
  if n == 0 then
    return #[]

  let m := n - 1
  let mut row := Array.mkEmpty n
  let mut coeff : Nat := 1
  row := row.push coeff

  for k in [0:m] do
    coeff := (coeff * (m - k)) / (k + 1)
    row := row.push coeff

  return row

structure Triangle where
  getRow : Nat -> TriangleM (Array Nat)

instance : CoeFun Triangle (fun _ => Nat -> TriangleM (Array Nat)) where
  coe t := t.getRow

syntax:arg term noWs "(" term ")" : term

macro_rules
  | `($triangle($n)) => `(($triangle) $n)

def mkTriangle : TriangleM Triangle := do
  let rowsRef : IO.Ref (List (Nat × Array Nat)) <- IO.mkRef [(0, #[])]
  let getRow : Nat -> TriangleM (Array Nat) := fun n => do
    let rows <- rowsRef.get
    match rows.find? (fun p => p.fst == n) with
    | some (_, row) =>
        return row
    | none =>
        let row := mkRowBinomial n
        rowsRef.set ((n, row) :: rows)
        return row
  return { getRow }

end PascalsTriangle