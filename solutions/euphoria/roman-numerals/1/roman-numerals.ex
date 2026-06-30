include std/sequence.e
include std/text.e

public function roman(integer val)
  sequence res = ""
  sequence str = sprint(val)
  sequence numerals = split(" I II III IV V VI VII VIII IX")
  for i = 1 to length(str) do
    res = mapping(res, "IVXLC", "XLCDM") & numerals[str[i] - '0' + 1]
  end for
  return res
end function