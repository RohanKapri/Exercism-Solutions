include std/text.e

sequence scores = {1, 3, 3, 2, 1, 4, 2, 4, 1, 8, 5, 1, 3, 1, 1, 3, 10, 1, 1, 1, 1, 4, 4, 8, 4, 10}

public function score(sequence word)
  integer res = 0
  for i = 1 to length(word) do
    res += scores[lower(word[i]) - 'a' + 1]
  end for
  return res
end function