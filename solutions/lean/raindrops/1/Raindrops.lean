namespace Raindrops

def convert (number : Nat) : String :=
  match
    [(3, "Pling"), (5, "Plang"), (7, "Plong")].filterMap 
      fun (d, s) => if (d ∣ number) then some s else none
  with
  | [] => s!"{number}"
  | xs => String.join xs

end Raindrops