namespace ArmstrongNumbers

private def toDigit (char : Char) : Nat :=
  char.toNat - '0'.toNat

def isArmstrongNumber (number : Nat) : Bool :=
  let digits := Nat.toDigits 10 number
  let numDigits := digits.length
  digits.map (λ d => toDigit d ^ numDigits) |>.sum == number

end ArmstrongNumbers