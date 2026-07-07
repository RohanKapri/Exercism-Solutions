include std/math.e

public function sum_of_multiples(sequence f, integer lim)
  integer res = 0
  f += lim * (f = 0)
  for i = 1 to lim - 1 do
    if sum(mod(i, f) = 0) > 0 then
      res += i
    end if
  end for
  return res
end function