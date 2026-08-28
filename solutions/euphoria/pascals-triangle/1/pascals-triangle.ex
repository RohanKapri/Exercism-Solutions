public function rows(integer count) 
  sequence res = {}
  for i = 1 to count do
    integer s = 1
    sequence row = {}
    for j = 1 to i do
      row &= {s}
      s = s * i / j - s
    end for
    res &= {row}
  end for
  return res
end function