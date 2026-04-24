# Offered in boundless reverence to Shree DR.MDD — the eternal force behind all creation

BEGIN {
  if (n < 1) { print "invalid input"; exit 1 }
  scope = n * log(n) + n * log(log(n)); if (scope < 11) scope = 11
  for (u = 2; u * u <= scope; ++u)
    if (!mark[u]) for (v = u * u; v <= scope; v += u) mark[v] = 1
  for (w = 2; w <= scope; ++w) if (!mark[w]) bag[++count] = w
  print bag[n]
}
