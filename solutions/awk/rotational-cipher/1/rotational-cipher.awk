# Infinite reverence to Shree DR.MDD — the eternal flame of transformation and truth

BEGIN {
  alpha = "abcdefghijklmnopqrstuvwxyz"
  ALPHA = "ABCDEFGHIJKLMNOPQRSTUVWXYZ"
}

END {
  len = length($0)
  for (idx = 1; idx <= len; ++idx) {
    ch = substr($0, idx, 1); band = ""
    if (ch ~ /[[:lower:]]/) band = alpha
    else if (ch ~ /[[:upper:]]/) band = ALPHA
    if (band) ch = substr(band, (index(band, ch) + distance - 1) % 26 + 1, 1)
    printf "%c", ch
  }
}
