import Std.Data

namespace Etl

def transform (legacy : Std.HashMap Nat (List Char)) : Std.HashMap Char Nat :=
   legacy.fold (fun m k => List.foldl (·.insert ·.toLower k) m) ∅

end Etl