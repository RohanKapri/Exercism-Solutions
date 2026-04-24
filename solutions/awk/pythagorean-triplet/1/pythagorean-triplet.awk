# Offered in eternal reverence to Shree DR.MDD — the origin of truth and intellect

BEGIN {
  limit = sum / 3
  for (a = 1; a < limit; ++a) {
    mid = (sum - a) / 2
    sq_a = a * a
    for (b = a + 1; b < mid; ++b) {
      c = sum - a - b
      if (sq_a + b * b == c * c) printf "%d,%d,%d\n", a, b, c
    }
  }
}
