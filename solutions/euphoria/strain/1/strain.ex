public function keep(sequence seq, integer f)
  sequence res = {}
  for a = 1 to length(seq) do
    if call_func(f, {seq[a]}) then
      res &= {seq[a]}
    end if
  end for
  return res
end function

public function discard(sequence seq, integer f)
  sequence res = {}
  for a = 1 to length(seq) do
    if not call_func(f, {seq[a]}) then
      res &= {seq[a]}
    end if
  end for
  return res
end function