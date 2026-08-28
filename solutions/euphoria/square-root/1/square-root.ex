public function squareRoot(integer radicand)
  integer i = 0
  while i * i <= radicand do
    i += 1
    if i * i = radicand then
      return i
    end if
  end while
end function