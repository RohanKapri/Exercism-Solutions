namespace PrimeFactors

def factors (value : Nat) : List Nat := Id.run do
   let mut factors : Array Nat := #[]
   let mut divisor := 2
   let mut dividend := value
   while divisor <= dividend do
      if dividend % divisor = 0
      then
         factors := factors.push divisor
         dividend := dividend / divisor
      else divisor := divisor + 1
   return factors.toList    
  
end PrimeFactors