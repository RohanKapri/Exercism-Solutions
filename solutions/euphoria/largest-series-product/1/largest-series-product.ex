include std/math.e
include std/sequence.e

public function largestProduct(sequence digits, integer span)
  if span = 0 then
    return 1
  elsif equal(digits, "") or sum(digits < '0' or digits > '9') or span < 0 or span > length(digits) then
    return -1
  end if
  integer res = 0
  for i = 1 to length(digits) - span + 1 do
    integer prod = product(slice(digits, i, i + span - 1) - '0')
    if prod > res then
      res = prod
    end if
  end for
  return res
end function