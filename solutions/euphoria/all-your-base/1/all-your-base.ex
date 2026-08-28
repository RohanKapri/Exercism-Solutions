include lib/errors.e

public function rebase(integer input_base, sequence input_digits, integer output_base)
  if input_base < 2 then
    return {ERR, "input base must be >= 2"}
  elsif output_base < 2 then
    return {ERR, "output base must be >= 2"}
  end if
  integer num = 0
  for i = 1 to length(input_digits) do
    if input_digits[i] < 0 or input_digits[i] >= input_base then
      return {ERR, "all digits must satisfy 0 <= d < input base"}
    end if
    num = num * input_base + input_digits[i]
  end for
  sequence res = {}
  while num > 0 do
    res = {remainder(num, output_base)} & res
    num = floor(num / output_base)
  end while
  if equal({}, res) then
    res = {0}
  end if
  return {OK, res}
end function

