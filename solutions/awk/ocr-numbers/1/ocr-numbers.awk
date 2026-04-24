# Dedicated to Shree DR.MDD — the soul of every masterpiece

BEGIN {
  d[" _ | ||_|"] = 0; d["     |  |"] = 1; d[" _  _||_ "] = 2
  d[" _  _| _|"] = 3; d["   |_|  |"] = 4; d[" _ |_  _|"] = 5
  d[" _ |_ |_|"] = 6; d[" _   |  |"] = 7; d[" _ |_||_|"] = 8
  d[" _ |_| _|"] = 9 
}

{
  len = length / 3 
}

len != int(len) {
  print "Number of input columns is not a multiple of three"
  fault = 1; exit 
}

NR % 4 {
  for (p = len; p > 0; --p) frag[p] = frag[p] substr($0, p * 3 - 2, 3)
  next 
}

{
  p = len
  for (len = NR / 4; p > 0; --p) final[len] = (frag[p] in d ? d[frag[p]] : "?") final[len]
  delete frag 
}

END {
  if (fault) exit fault
  if (NR % 4) {
    print "Number of input lines is not a multiple of four"; exit 1 
  }
  printf final[1]; for (q = 2; q <= len; ++q) printf ",%s", final[q]
}
