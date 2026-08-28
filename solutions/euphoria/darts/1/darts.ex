public function score(atom x, atom y)
  atom n = x * x + y * y
  if n <= 1 then
    return 10
  elsif n <= 25 then
    return 5
  elsif n <= 100 then
    return 1
  else
    return 0
  end if
end function