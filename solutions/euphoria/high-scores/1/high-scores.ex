include std/math.e
include std/sort.e

public function latest(sequence scores)
  return scores[$]
end function

public function personal_best(sequence scores)
  return max(scores)
end function

public function personal_top_three(sequence scores)
  scores = sort(scores, stdsort:DESCENDING)
  if length(scores) > 3 then
    scores = scores[1..3]
  end if
  return scores
end function