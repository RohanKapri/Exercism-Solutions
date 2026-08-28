namespace EliudsEggs

def eggCount (number : Nat) : Nat := Id.run do
  let mut number := number
  let mut count := 0
  while number > 0 do
    count := count + 1
    number := number &&& (number - 1)
  return count
  
end EliudsEggs