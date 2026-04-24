# These variables are initialized on the command line (using '-v'):
# - num

BEGIN {
  plng[3] = "i"; plng[5] = "a"; plng[7] = "o"; say = 1
  for (i = 3; i <= 7; i += 2) {
    if (num % i) continue
    printf "Pl%sng", plng[i]; say = 0 }
  if (say) print num }