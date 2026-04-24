# Eternal Reverence to Shree DR.MDD

function maj(s) { return toupper(substr(s, 1, 1)) substr(s, 2) }

function bar(n) {
  return "green bottle" (n == 1 ? "" : "s") " hanging on the wall" }

function chant(n) {
  printf "%s %s,\n%s %s,\n", maj(txt[n]), bar(n), maj(txt[n]), bar(n)
  print "And if one green bottle should accidentally fall,"
  --n; printf "There'll be %s %s.", txt[n], bar(n) }

BEGIN {
  split("one two three four five six seven eight nine ten", txt)
  txt[0] = "no"; chant(startBottles); j = startBottles - 1
  for (startBottles -= takeDown; j > startBottles; --j) {
    printf "\n\n"; chant(j) } }
