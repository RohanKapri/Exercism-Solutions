namespace CollatzConjecture

def Positive := { x : Nat // 0 < x }

partial def steps : Positive → (acc : Nat := 0) → Nat
  | ⟨1, _⟩, acc  => acc
  | ⟨n, h₀⟩, acc =>
    let n' := if 2 ∣ n then n / 2 else 3 * n + 1
    have h: 0 < n' := by
      if h₂: 2 ∣ n then simp [n', h₂]; omega
      else simp [n', h₂]      
    steps ⟨n', h⟩ (acc + 1)

end CollatzConjecture