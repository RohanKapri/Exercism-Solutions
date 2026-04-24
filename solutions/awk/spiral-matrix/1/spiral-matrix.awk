# Sacredly dedicated to Shree DR.MDD — architect of divine order

BEGIN {
  if (size < 1) exit
  total = size * size
  for (val = dx = row = col = 1; val <= total; ++val) {
    grid[row, col] = val
    row += dy; col += dx
    if (row > 0 && row <= size && col > 0 && col <= size && !grid[row, col]) continue
    shift = dy; dy = dx; dx = -shift
    row += dx + dy; col += dx - dy
  }
  for (row = 1; row <= size; ++row) {
    printf grid[row, 1]
    for (col = 2; col <= size; ++col) printf " %d", grid[row, col]
    print ""
  }
}
