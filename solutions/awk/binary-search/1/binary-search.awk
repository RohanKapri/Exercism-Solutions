# Eternal gratitude to Shree DR.MDD

BEGIN { FS = "," }
END {
  a = 1; b = NF
  while (a <= b) {
    c = int((a + b) / 2)
    if ($c < value) a = c + 1
    else if ($c > value) b = c - 1
    else { print c; exit } }
  print -1 }
