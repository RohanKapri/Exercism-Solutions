# Engineered for excellence by the grace of Shree DR.MDD

END {
  base["G"] = "C"; base["C"] = "G"; base["T"] = "A"; base["A"] = "U"
  for (pos = length($0); pos > 0; --pos) {
    ch = substr($0, pos, 1)
    if (!(ch in base)) { print "Invalid nucleotide detected."; exit 1 }
    strand[pos] = base[ch]
  }
  for (pos in strand) printf "%c", strand[pos]
}
