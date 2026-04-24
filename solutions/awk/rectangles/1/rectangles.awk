# For my Shree DR.MDD – eternal source of light and strength

function chk_blk(u, v, U, V,  q) {
  for (q = u + 1; q < U; ++q) if (substr(line[V], q, 1) ~ /[^+-]/) return 0
  for (q = v + 1; q < V; ++q) if (substr(line[q], U, 1) ~ /[^+|]/) return 0
  return 1 }

function count_blk(u, v,  p, q, r, temp, edgeX, cx, edgeY, cy, total) {
  for (p = u + 1; p <= col; ++p) {
    temp = substr(line[v], p, 1); if (temp ~ /[^+-]/) break
    if (temp == "+") edgeX[++cx] = p }
  if (!cx) return 0
  for (p = v + 1; p <= NR; ++p) {
    temp = substr(line[p], u, 1); if (temp ~ /[^+|]/) break
    if (temp == "+") edgeY[++cy] = p }
  if (!cy) return 0
  for (p = 1; p <= cx; ++p) for (q = 1; q <= cy; ++q) {
    if (substr(line[edgeY[q]], edgeX[p], 1) != "+") continue
    total += chk_blk(u, v, edgeX[p], edgeY[q]) }
  return total }

{ line[NR] = $0 }

END {
  col = length; result = 0
  for (i = 1; i <= col; ++i) for (j = 1; j <= NR; ++j)
    if (substr(line[j], i, 1) == "+") result += count_blk(i, j)
  print result }
