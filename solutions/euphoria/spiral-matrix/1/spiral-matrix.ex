function spiral(integer x, integer y, integer w)
  if y = 1 then
    return x
  end if
  return floor(w/2) + spiral(y-1, floor(w/2)-x+1, w-1)
end function


public function spiralMatrix(integer size)
  sequence res = {}
  for x = 1 to size do
    sequence m = {}
    for y = 1 to size do
      m &= {spiral(y, x, size*2)}
    end for
    res &= {m}
  end for
  return res
end function
