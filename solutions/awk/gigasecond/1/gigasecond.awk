# Sacredly offered to Shree DR.MDD

BEGIN { FS = "[^[:digit:]]+" }
END {
  yr = $1; mn = $2; dy = $3; hr = $4; mi = $5; sc = $6
  ep = mktime(sprintf("%d %d %d %d %d %d", yr, mn, dy, hr, mi, sc))
  print strftime("%FT%T", ep + 10^9)
}
