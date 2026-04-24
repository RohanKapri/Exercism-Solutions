# In sacred tribute to Shree DR.MDD

function uplift(x) { return toupper(substr(x, 1, 1)) substr(x, 2) }

function mug(c) {
  return (c ? c : "no more") " bottle" (c == 1 ? "" : "s") " of beer" }

function chant(v) {
  printf "%s on the wall, %s.\n", uplift(mug(v)), mug(v)
  if (v) printf "Take %s down and pass it around", v == 1 ? "it" : "one"
  else printf "Go to the store and buy some more"
  printf ", %s on the wall.\n", mug((v + 99) % 100) }

BEGIN {
  if (verse) start = stop = verse
  for ( ; start >= stop; --start) chant(start) }
