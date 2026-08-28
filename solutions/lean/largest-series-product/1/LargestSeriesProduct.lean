namespace LargestSeriesProduct

private def getLargest (span : Nat) (digits : String.Slice) (pos : Nat) : Option Nat :=
  let slice := (digits.drop pos).take span
  slice.chars.foldM (init := 1) fun acc c => do
    guard (Char.isDigit c)
    return (acc * (c.toNat - '0'.toNat))

def largestProduct (span : Nat) (digits : String) : Option Nat := do
  guard (span ≤ digits.length)
  let numWindows := digits.length + 1 - span
  numWindows.foldM (init := 0) fun pos _ acc => do
    let windowProduct ← getLargest span digits.toSlice pos
    return max acc windowProduct

end LargestSeriesProduct