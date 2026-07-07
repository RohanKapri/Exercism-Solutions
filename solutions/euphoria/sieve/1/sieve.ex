include std/sequence.e

public function primes(integer limit)
  sequence res = {}
  for i = 2 to limit do
    res &= {i}
  end for
  integer i = 0
  while i < length(res) do
    i += 1
    for j = res[i] * 2 to limit by res[i] do
      res = remove_all(j, res)
    end for
  end while
  return res
end function