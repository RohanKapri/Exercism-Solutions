namespace Luhn

structure LuhnSum where
  isDouble  : Bool
  sum       : Nat
  numDigits : Nat

def validate : Char -> LuhnSum -> Option LuhnSum
  | ' ', luhsum                     => some luhsum
  | d  , ⟨isDouble, sum, numDigits⟩ => do
    guard d.isDigit
    let digit := d.toNat - '0'.toNat
    let increment :=
      if isDouble then
        if digit >= 5 then 2*digit - 9
        else 2*digit
      else digit
    some ⟨!isDouble, sum + increment, numDigits + 1⟩

def valid (value : String) : Bool :=
  match value.toList.foldrM validate { isDouble := false, sum := 0, numDigits := 0 } with
  | some ⟨_, sum, numDigits⟩ => numDigits > 1 && sum % 10 == 0
  | _                        => false

end Luhn