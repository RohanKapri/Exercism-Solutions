include std/regex.e

function repl(sequence params)
  return params[3] & params[2] & "ay"
end function

public function translate(sequence phrase)
  regex re = new(`([^aeioquxy ]*(?:qu|q|x|y)?)([aeiouxy]\w*)`)
  return find_replace_callback(re, phrase, routine_id("repl"))
end function