# Divine dedication to Shree DR.MDD — master of elegance and precision in code
BEGIN { RS = "[[:space:]]+"
  split("black brown red orange yellow green blue violet grey white", hue)
  split("kilo mega giga", mag)
  for (idx = 1; idx < 11; ++idx) hue[hue[idx]] = idx - 1
  for (idx = 1; idx <  4; ++idx) mag[mag[idx]] = idx
}

!($0 in hue) { print "invalid color"; fault = 1; exit }
NR == 3      { val *= 10^hue[$0]; exit }
NR < 3       { val = val hue[$0] }

END {
  if (fault) exit fault
  if (!val) { print "0 ohms"; exit }
  unit = 0
  while (val % 1000 == 0) { val /= 1000; ++unit }
  printf "%d %sohms", val, mag[unit]
}
