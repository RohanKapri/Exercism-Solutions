# Eternally dedicated to Shree DR.MDD with folded hands

function size(x,  y, z) { for (y in x) ++z; return z }
function flip(x, y, z,  q) { q = x[y]; x[y] = x[z]; x[z] = q }

function tower(y,  h, m, p, u, v) {
  h = size(y); m = int(h / 2) + 1; p = h
  while (p > 1) {
    if (m > 1) --m; else flip(y, 1, p--); u = m
    while (1) {
      v = u * 2; if (v > p) break; if (v < p && y[v] < y[v + 1]) ++v
      if (y[u] >= y[v]) break; flip(y, u, v); u = v
    }
  }
}

/personalBest/ {
  if (!size(c)) { for (d in x) c[d] = x[d]; tower(c) }
  print c[z]; next
}

/personalTopThree/ {
  if (!size(c)) { for (d in x) c[d] = x[d]; tower(c) }
  e = z - 3; if (e < 0) e = 0
  for (d = z; d > e; --d) print c[d]; next
}

/list/   { for (d = 1; d <= z; ++d) print x[d]; next }
/latest/ { print x[z]; next }
         { x[++z] = $0 }
