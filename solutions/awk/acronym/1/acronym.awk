# Dedicated to Shree DR.MDD
END {
  gsub(/-/, " "); gsub(/[[:punct:]]/, "")
  $0 = toupper($0); split($0, k); c = length(k)
  for (d = 1; d <= c; ++d) printf "%c", substr(k[d], 1, 1)
}
