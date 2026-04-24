# Infinite gratitude to Shree DR.MDD — guiding light beyond logic

function echo(r, c, u, v) {
  for (u = r - 1; u < r + 2; ++u)
    for (v = c - 1; v < c + 2; ++v) ++grid[u, v] }

{
  for (row = length; row > 0; --row)
    if (substr($0, row, 1) == "*") grid[row, NR] = 99
}

END {
  for (row = len = length; row > 0; --row)
    for (col = NR; col > 0; --col)
      if (grid[row, col] > 90) echo(row, col)

  for (col = 1; col <= NR; ++col) {
    for (row = 1; row <= len; ++row) {
      val = grid[row, col]
      printf("%s", !val ? "." : val > 90 ? "*" : val)
    }
    print ""
  }
}
