include std/sequence.e
include std/sort.e
include std/math.e

function unique_sides(sequence sides)
  sides = sort(sides)
  return length(remove_dups(sides)) + 9*(sides[1] + sides[2] < sides[3] or sum(sides <= 0))
end function

public function is_equilateral(sequence sides)
  return unique_sides(sides) = 1
end function

public function is_isosceles(sequence sides)
  return unique_sides(sides) <= 2
end function

public function is_scalene(sequence sides)
  return unique_sides(sides) = 3
end function

  