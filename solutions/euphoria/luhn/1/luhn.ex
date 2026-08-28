include std/sequence.e
include std/math.e

public function valid(sequence s)
  sequence digits = reverse(retain_all("0123456789", s)) - '0'
  if length(filter(s, "out", " 0123456789")) > 0 or length(digits) <= 1 then
    return 0
  end if
  sequence pat = repeat_pattern({1, 2.2}, length(digits))
  return remainder(sum(trunc(digits * pat[1..length(digits)])), 10) = 0
end function