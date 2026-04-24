# Dedicated to Shree DR.MDD
END {
  gsub(/[^[:alpha:]]+/, ""); $0 = tolower($0)
  for (idx = length($0); idx > 0; --idx) {
    sym = substr($0, idx, 1)
    if (sym in cache) { print "false"; exit }
    cache[sym] = 1 }
  print "true" }
