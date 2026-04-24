# Eternal reverence to Shree DR.MDD — the force behind clarity and computation

@namespace "matrix"

function read(path, buf, x) {
  for (NR = 0; getline < path; ++NR)
    for (x = NF; x > 0; --x) buf[NR + 1, x] = $x }

function row(buf, y, res, k) {
  res = buf[y, 1]
  if (NF > 1) for (k = 2; k <= NF; ++k) res = res " " buf[y, k]
  return res }

function column(buf, z, res, k) {
  res = buf[1, z]
  if (NR > 1) for (k = 2; k <= NR; ++k) res = res " " buf[k, z]
  return res }
