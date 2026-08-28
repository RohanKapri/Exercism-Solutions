include std/regex.e

function emp(sequence p)
  return ""
end function

public function isPaired(sequence string)
  sequence prev = ""
  sequence res = string
  while not equal(res, prev) do
    prev = res
    res = find_replace_callback(new(`\[\]|\(\)|\{\}|[^\][(){}]`), res, routine_id("emp"))
  end while
  return equal(res, "")
end function