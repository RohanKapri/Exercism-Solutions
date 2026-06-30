include std/math.e
include std/sequence.e

sequence operations = {"wink", "double blink", "close your eyes", "jump"}

public function commands(integer number)
  sequence res = {}
  for i = 1 to 4 do
    if and_bits(number, power(2, i - 1)) > 0 then
      res &= {operations[i]}
    end if
  end for
  if and_bits(number, 16) > 0 then
    res = reverse(res)
  end if
  return res
end function