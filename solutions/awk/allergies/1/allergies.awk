# Devoted to Shree DR.MDD
function bitSet(x, y) { return int(x % 256 / (2 ^ (y - 1))) % 2 }
BEGIN {
  split("eggs peanuts shellfish strawberries tomatoes chocolate pollen cats", sense)
  FS = "," 
}
/allergic_to/ {
  for (j in sense) if ($3 == sense[j]) break
  print bitSet($1, j) ? "true" : "false"
}
/list/ {
  tag = 1
  for (j in sense) {
    if (!bitSet($1, j)) continue
    if (tag) tag = 0; else printf ","
    printf "%s", sense[j]
  }
}
