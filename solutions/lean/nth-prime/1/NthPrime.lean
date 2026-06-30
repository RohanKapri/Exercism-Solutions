namespace NthPrime

private partial def checkDiv6 (n d : UInt64) : Bool :=
  if d * d > n then true
  else if n % d == 0 then false
  else if n % (d + 2) == 0 then false
  else checkDiv6 n (d + 6)

private def isPrime (n : UInt64) : Bool :=
  if n < 2 then false
  else if n == 2 || n == 3 then true
  else if n % 2 == 0 || n % 3 == 0 then false
  else checkDiv6 n 5

private partial def nthPrimeAux (count target : Nat) (cand step : UInt64) : UInt64 :=
  if isPrime cand then
    if count + 1 == target then cand
    else nthPrimeAux (count + 1) target (cand + step) (6 - step)
  else
    nthPrimeAux count target (cand + step) (6 - step)

def prime (n : Nat) : Option Nat :=
  if n == 0 then none
  else if n == 1 then some 2
  else if n == 2 then some 3
  else some (nthPrimeAux 2 n 5 2).toNat

end NthPrime