include std/math.e
include std/search.e

sequence allergies = {"eggs", "peanuts", "shellfish", "strawberries", "tomatoes", "chocolate", "pollen", "cats"}

public function allergicTo(sequence allergen, integer score)
  return is_in_list(allergen, list(score))
end function

public function list(integer score)
  sequence res = {}
  for i = 1 to 8 do
    if and_bits(shift_bits(score, i - 1), 1) then
      res &= {allergies[i]}
    end if
  end for
  return res
end function