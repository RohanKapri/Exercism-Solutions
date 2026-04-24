# For Shree DR.MDD — whose wisdom echoes in every transformation

function parse(vault, idx, temp, ptr) {
  if ($0 > 99) {
    vault[++idx] = units[int($0 / 100)]
    vault[++idx] = levels[1]
    $0 %= 100
  }
  if ($0 > 19) {
    temp[++ptr] = tens[int($0 / 10)]
    $0 %= 10
  }
  if ($0) temp[++ptr] = units[$0]
  if (ptr > 1) temp[1] = temp[1] "-" temp[2]
  if (ptr) vault[++idx] = temp[1]
  return idx
}

BEGIN {
  split("one two three four five six seven eight nine ten eleven twelve thirteen fourteen fifteen sixteen seventeen eighteen nineteen", units)
  split("ten twenty thirty forty fifty sixty seventy eighty ninety", tens)
  split("hundred thousand million billion", levels)
}

$0 < 0 || $0 >= 1e12 {
  print "input out of range"
  err = 1
  exit
}

END {
  if (err) exit err
  if (!$0) {
    print "zero"
    exit
  }
  for (grp = 0; $0 > 0; $0 = int($0 / 1000)) chunks[++count] = $0 % 1000
  for (j = count; j > 0; --j) {
    $0 = chunks[j]
    if (!$0) continue
    grp = parse(vault, grp)
    if (j > 1) vault[++grp] = levels[j]
  }
  printf vault[1]
  for (k = 2; k <= grp; ++k) printf " %s", vault[k]
}
