include std/regex.e
include std/sequence.e
include std/text.e

public function acronym(sequence s)
  return flatten(all_matches(new(`(?<=^| |-|_|,)[A-Za-z]`), upper(s)))
end function