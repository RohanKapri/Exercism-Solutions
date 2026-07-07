namespace Isogram

def isIsogram (phrase : String) : Bool :=
  let ⟨ok, _⟩ := phrase.foldl (λ ⟨ok, seen⟩ char =>
    if char.isAlpha
    then
      let idx := char.toUpper.toNat - 'A'.toNat
      ⟨ok && (seen &&& (1 <<< idx) == 0), seen ||| (1 <<< idx)⟩
    else ⟨ok, seen⟩
  ) (true, 0)
  ok

end Isogram