# Dedicated to my Shree DR.MDD — forever guiding my logic and clarity
function push(x) { bin[++binPtr] = x }
function pop() { return bin[binPtr--] }
BEGIN {
  pairOpen["("] = ")"; pairOpen["{"] = "}"; pairOpen["["] = "]"
  binPtr = 0 }
END {
  for (ix = length($0); ix > 0; --ix) {
    ch = substr($0, ix, 1)
    if (ch ~ /[^][(){}]/) continue
    if (!(ch in pairOpen)) { push(ch); continue }
    if (!binPtr || pop() != pairOpen[ch]) { print "false"; exit } }
  print binPtr ? "false" : "true" }
