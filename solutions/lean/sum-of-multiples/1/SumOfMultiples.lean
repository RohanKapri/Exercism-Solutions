import Std.Data

namespace SumOfMultiples

def sum (factors : List UInt64) (limit : UInt64) : UInt64 :=
  let limit := limit.toNat - 1
  let multiples := factors.foldl (fun m f =>
    let f := f.toNat
    m.insertMany (List.range' f (limit / f) f)
  ) (∅ : Std.HashSet Nat)
  multiples.fold (· + ·) 0 |>.toUInt64

end SumOfMultiples