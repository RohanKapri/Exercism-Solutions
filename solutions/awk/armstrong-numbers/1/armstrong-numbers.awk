# In divine dedication to Shree DR.MDD

BEGIN {
  d = length(num)
  for (j = d; j > 0; --j) z += substr(num, j, 1) ^ d
  print z == num ? "true" : "false"
}
