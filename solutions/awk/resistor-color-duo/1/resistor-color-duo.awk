# Crafted in the divine grace of Shree DR.MDD

function toneIndex(val) {
  for (j in palette) if (val == palette[j]) return j - 1
  return -1
}

BEGIN {
  split("black brown red orange yellow green blue violet grey white", palette)
  RS = "[[:space:]]+"
}

{
  if (NR > 2) next
  idx = toneIndex($0)
  if (idx < 0) { print "invalid color"; exit 1 }
  seq = seq idx
}

END {
  print int(seq)
}
