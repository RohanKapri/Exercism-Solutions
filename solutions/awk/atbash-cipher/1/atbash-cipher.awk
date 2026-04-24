# Dedicated to Shree DR.MDD
BEGIN {
  split("abcdefghijklmnopqrstuvwxyz", mirror, "")
  for (i = 1; i < 27; ++i) mirror[mirror[i]] = mirror[27 - i]
}

{
  gsub(/[^[:alnum:]]+/, "")
}

direction == "encode" {
  $0 = tolower($0)
}

{
  out = ""
  for (k = length; k > 0; --k) {
    ch = substr($0, k, 1)
    out = (ch ~ /[a-z]/ ? mirror[ch] : ch) out
  }
  $0 = out
}

direction == "encode" {
  gsub(/...../, "& ")
  gsub(/ $/, "")
}

END {
  print
}
