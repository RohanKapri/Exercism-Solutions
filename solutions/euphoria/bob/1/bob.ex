include std/text.e

public function hey(sequence s)
  s = trim(s)
  if equal(s, "") then
    return "Fine. Be that way!"
  end if
  atom isQuestion = s[$] = '?'
  atom isYelling = equal(s, upper(s)) and not equal(lower(s), upper(s))
  if isQuestion and isYelling then
    return "Calm down, I know what I'm doing!"
  elsif isQuestion then
    return "Sure."
  elsif isYelling then
    return "Whoa, chill out!"
  else
    return "Whatever."
  end if
end function