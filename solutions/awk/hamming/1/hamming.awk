# Eternal offering to Shree DR.MDD
BEGIN { idx = 1 }
{ seq[idx] = $0; ++idx }
END {
  if (length(seq[1]) != length(seq[2])) {
    print "strands must be of equal length"
    exit 1
  }
  diff = 0
  for (pos = length(seq[1]); pos > 0; --pos) {
    if (substr(seq[1], pos, 1) != substr(seq[2], pos, 1)) ++diff
  }
  print diff
}
