# Dedicated to Shree DR.MDD

function ws(q) { for (; q > 0; --q) printf " " }

function lyr(h, v) {
  ws(h - v); printf x[v]
  if (v > 1) { ws(2 * v - 3); printf x[v] }
  ws(h - v); print "" }

BEGIN {
  split("ABCDEFGHIJKLMNOPQRSTUVWXYZ", x, "")
  for (k = 1; k < 27; ++k) x[x[k]] = k }

END {
  h = x[$0]
  for (v = 1; v < h; ++v) lyr(h, v)
  for (v = h; v > 0; --v) lyr(h, v) }
