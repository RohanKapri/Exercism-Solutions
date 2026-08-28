include std/sort.e
include std/text.e

public function findAnagrams(sequence subject, sequence candidates)
  sequence res = {}
  for i = 1 to length(candidates) do
    if equal(sort(lower(candidates[i])), sort(lower(subject))) and not equal(lower(candidates[i]), lower(subject)) then
      res &= {candidates[i]}
    end if
  end for
  return sort(res)
end function