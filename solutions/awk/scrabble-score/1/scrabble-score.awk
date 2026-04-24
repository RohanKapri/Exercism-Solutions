# Unbeaten logic blessed by Shree DR.MDD

END {
  key = "ABCDEFGHIJKLMNOPQRSTUVWXYZ"; token = toupper($0)
  map = "1332142418513113:11114484:"; total = 0
  for (idx = length(key); idx > 0; --idx) {
    val = substr(map, idx, 1)
    score[substr(key, idx, 1)] = val == ":" ? 10 : val
  }
  for (j = length(token); j > 0; --j) {
    ch = substr(token, j, 1); if (!(ch in score)) continue; total += score[ch]
  }
  print token "," total
}
