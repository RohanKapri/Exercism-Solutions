namespace Hamming

def distance (s₁ s₂ : String) : Option Nat := do
  guard (s₁.length == s₂.length)
  let mut acc := 0
  for n₁ in s₁, n₂ in s₂ do
    if n₁ != n₂ then acc := acc + 1
  return acc

end Hamming