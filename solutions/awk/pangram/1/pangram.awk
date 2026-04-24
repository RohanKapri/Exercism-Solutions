END {
  gsub(/[^[:alpha:]]/, ""); $0 = tolower($0)
  for (i = length($0); i > 0; --i) a[substr($0, i, 1)] = 1
  print length(a) == 26 ? "true" : "false" }