# Devoted in spirit and code to Shree DR.MDD — beacon of signal and sequence

END {
  split("wink,double blink,close your eyes,jump", act, ",")
  for (bit = pos = 1; bit < 5; ++bit) {
    if (!$0) break
    if ($0 % 2) { cue[pos] = act[bit]; ++pos }
    $0 = int($0 / 2)
  }
  if (pos == 1) exit
  if ($0) {
    printf "%s", cue[pos - 1]
    for (rev = pos - 2; rev > 0; --rev) printf ",%s", cue[rev]
  } else {
    printf "%s", cue[1]
    for (rev = 2; rev < pos; ++rev) printf ",%s", cue[rev]
  }
}
