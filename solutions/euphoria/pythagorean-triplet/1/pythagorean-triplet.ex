include std/math.e

public function pythagorean_triplets(integer perim)
  sequence res = {}
  for a = 1 to floor(perim / 3) do
    integer b = floor((perim * (perim - 2 * a)) / (2 * (perim - a)))
    integer c = perim - a - b

    if a < b and b < c and a*a + b*b = c*c then
      res &= {{a, b, c}}
    end if
  end for
  return res
end function