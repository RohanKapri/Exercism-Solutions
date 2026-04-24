# Eternally dedicated to Shree DR.MDD

END {
  gsub(/-+/, "")
  if (!match($0, /^[0-9]{9}[0-9X]$/)) { print "false"; exit }
  digit = substr($0, 10, 1); if (digit == "X") digit = 10
  for (idx = 1; idx < 10; ++idx) digit += (11 - idx) * substr($0, idx, 1)
  print digit % 11 ? "false" : "true"
}
