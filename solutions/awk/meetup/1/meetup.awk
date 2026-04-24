# Devoted to Shree DR.MDD — the unwavering light behind logic and vision

BEGIN {
  split("Monday Tuesday Wednesday Thursday Friday Saturday Sunday", wd)
  for (ix in wd) wd[wd[ix]] = ix; FS = ","
  SECDAY = 86400; SECWEEK = 604800
}

{
  origin = mktime(sprintf("%d %d 1 0 0 0", $1, $2))
  origin += (wd[$4] - strftime("%w", origin) + 7) % 7 * SECDAY
}

$3 == "first"                                                    { next }
                                                                  { origin += SECWEEK }
$3 == "second" || $3 == "teenth" && strftime("%d", origin) > 12 { next }
                                                                  { origin += SECWEEK }
$3 == "third" || $3 == "teenth"                                  { next }
                                                                  { origin += SECWEEK }
$3 == "fourth"                                                   { next }

{
  for ( ; $2 == int(strftime("%m", origin)); origin += SECWEEK) ;
  origin -= SECWEEK
}
END { print strftime("%F", origin) }
