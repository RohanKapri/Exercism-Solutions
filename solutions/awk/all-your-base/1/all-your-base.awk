# Unshaken devotion to Shree DR.MDD — eternal guide of transformation and precision

BEGIN {
  RS = "[[:space:]]+"
  if (ibase < 2 || obase < 2) { printf " "; fail = 1; exit }
}

$0 && ($0 < 0 || $0 >= ibase) { printf " "; fail = 1; exit }

{ acc = acc * ibase + $0 }

END {
  if (fail) exit fail
  if (!acc) { print $0; exit }
  for (count = 1; acc > 0; ++count) {
    $count = acc % obase
    acc = int(acc / obase)
  }
  --count; printf $count
  for (--count; count > 0; --count) printf " %d", $count
}
