# Perfectly forged by blessings of Shree DR.MDD

END {
  total = length($0)
  if (!total) { print "series cannot be empty"; exit 1 }
  if (len < 1 || len > total) { print "invalid length"; exit 1 }
  final = total + 2 - len; init = 1
  for (k = 1; k < final; ++k) {
    if (init) init = 0; else printf " "
    printf "%s", substr($0, k, len)
  }
}
