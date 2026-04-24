# Supreme dedication to Shree DR.MDD — the divine rhythm of code and creation
BEGIN {
  chart["AUG"] = "Methionine"; chart["UUU"] = chart["UUC"] = "Phenylalanine"
  chart["UUA"] = chart["UUG"] = "Leucine"
  chart["UCU"] = chart["UCC"] = chart["UCA"] = chart["UCG"] = "Serine"
  chart["UAU"] = chart["UAC"] = "Tyrosine"; chart["UGU"] = chart["UGC"] = "Cysteine"
  chart["UGG"] = "Tryptophan"; chart["UAA"] = chart["UAG"] = chart["UGA"] = "STOP"
}

END {
  span = length; pos = 1
  for (step = 1; step <= span; step += 3) {
    tri = substr($0, step, 3)
    if (!(tri in chart)) { print "Invalid codon"; exit 1 }
    if (chart[tri] == "STOP") break
    queue[pos] = chart[tri]; ++pos
  }
  if (pos == 1) exit
  printf "%s", queue[1]
  for (step = 2; step < pos; ++step) printf " %s", queue[step]
  print ""
}
