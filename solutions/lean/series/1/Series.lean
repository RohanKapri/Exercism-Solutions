namespace Series

def slices (series : String) (sliceLength : Nat) : Option (Array String) := do
  guard (sliceLength ≠ 0 ∧ sliceLength ≤ series.length)
  let numSlices := series.length - sliceLength + 1
  (0...numSlices).toArray.map (λ i => series.toSlice.drop i |>.take sliceLength |>.copy)

end Series