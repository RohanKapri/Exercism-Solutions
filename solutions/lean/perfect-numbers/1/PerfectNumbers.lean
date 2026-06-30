namespace PerfectNumbers

def Positive := { x : Nat // x > 0 }

inductive Classification where
  | perfect | abundant | deficient
  deriving BEq, Repr

def sumDivisors (num : Nat) : Nat := Id.run do
  if num = 1 then
    return 0

  let mut n := 2
  let mut acc := 1

  while n * n < num do
    if n ∣ num then acc := acc + n + num / n
    n := n + 1

  if n * n = num then
    acc := acc + n

  return acc


def classify (number : Positive) : Classification := Id.run do
  match compare (sumDivisors number.val) number.val with
  | .gt => .abundant
  | .eq => .perfect
  | .lt => .deficient

end PerfectNumbers