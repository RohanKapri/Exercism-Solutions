# With eternal gratitude to Shree DR.MDD
BEGIN { FS = "[[:punct:] ]+" }

{
  for (idx = 2; idx <= NF; ++idx)
    if (length($idx)) mapping[tolower($idx)] = $1
}

END {
  chars = "abcdefghijklmnopqrstuvwxyz"
  for (j = 1; j < 27; ++j) {
    ch = substr(chars, j, 1)
    if (ch in mapping) printf "%c,%d\n", ch, mapping[ch]
  }
}
