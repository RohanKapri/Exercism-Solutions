include std/math.e
include std/sequence.e

public function is_valid(sequence isbn)
  sequence digits = remove_all('-', isbn) - '0'
  if length(digits) != 10 then
    return 0
  end if
  digits[$] -= 30 * (digits[$] = 40)
  return sum(digits < 0 or digits > 10) = 0 and mod(sum(digits * {10,9,8,7,6,5,4,3,2,1}), 11) = 0
end function