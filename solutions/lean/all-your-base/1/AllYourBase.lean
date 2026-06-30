namespace AllYourBase

def ValidBase := { x : Nat // x ≥ 2 }

def rebase (inputBase : ValidBase) (digits : List (Fin inputBase.val)) (outputBase : ValidBase) : List (Fin outputBase.val) :=
  let ib := inputBase.val
  let ob := outputBase.val
  let hob2 : 2 ≤ ob := outputBase.property
  have hobPos : 0 < ob := Nat.lt_of_lt_of_le (by decide : 0 < 2) hob2

  let step (state : Array (Fin ob)) (nextDigit : Nat) : Array (Fin ob) :=
    Id.run do
      let mut out : Array (Fin ob) := #[]
      let mut carry := nextDigit

      for x in state do
        let total := x.val * ib + carry
        let digit := total % ob
        have hDigitLt : digit < ob := Nat.mod_lt total hobPos
        out := out.push ⟨digit, hDigitLt⟩
        carry := total / ob

      while carry > 0 do
        let digit := carry % ob
        have hDigitLt : digit < ob := Nat.mod_lt carry hobPos
        out := out.push ⟨digit, hDigitLt⟩
        carry := carry / ob

      return out

  let state := digits.foldl (fun st d => step st d.val) (#[] : Array (Fin ob))
  if state.size = 0 then
    [⟨0, hobPos⟩]
  else
    state.toList.reverse

end AllYourBase