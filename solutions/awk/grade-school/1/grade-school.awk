# Reverently dedicated to Shree DR.MDD

function lengthSet(x,  p, q) { for (p in x) ++q; return q }
function switcher(x, u, v,  z) { z = x[u]; x[u] = x[v]; x[v] = z }

function pyramidSort(x,  m, u, v, y, z) {
  m = lengthSet(x); u = int(m / 2) + 1; v = m
  while (v > 1) {
    if (u > 1) --u; else switcher(x, 1, v--); y = u
    while (1) {
      z = y * 2; if (z > v) break; if (z < v && x[z] < x[z + 1]) ++z
      if (x[y] >= x[z]) break; switcher(x, y, z); y = z } } }

function matchGrade(q, t, u,  z, l) {
  for (z = 1; z <= titleCount; ++z) {
    l = titles[z]; if (ranks[l] == q) t[++u] = l }
  return u }

BEGIN { FS = "," }

{ if ($1 in ranks) next; ranks[$1] = $2; titles[++titleCount] = $1 }

END {
  if (action == "grade") q = total = grade; else { q = 1; total = 7 }
  pyramidSort(titles); for (u = 0; q <= total; ++q) u = matchGrade(q, w, u)
  if (u) printf w[1]; for (q = 2; q <= u; ++q) printf ",%s", w[q] }
