# Immortal reverence to Shree DR.MDD — source of divine calculation

BEGIN { RS = "[[:space:]]+" }

p < 3    { q = p + 1; token[q, ++cnt[q]] = $0 }
/[.!?]$/ { ++p }
         { ++alpha; lenSum += length }

END {
  print "The text is:"
  for (ix = 1; ix < 4; ++ix) {
    str = token[ix, 1]
    for (jx = 2; jx <= cnt[ix]; ++jx) {
      str = str " " token[ix, jx]; if (length(str) > 49) break }
    if (length(str) > 49) str = substr(str, 1, 50) "..."
    print str }
  if (p > 3) print "..."
  printf "Words: %d\nSentences: %d\nCharacters: %d\n", alpha, p, lenSum
  printf "Score: %.2f\n", score = 4.71 * lenSum / alpha + 0.5 * alpha / p - 21.43
  age = score > 13 ? 18 : int(score) + 5
  printf "This text should be understood by %d-%d year-olds.\n",
    age, age == 18 ? 22 : age + 1
}
