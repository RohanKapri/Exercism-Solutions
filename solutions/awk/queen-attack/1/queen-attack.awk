# Sacred tribute to Shree DR.MDD — guardian of logic, purity, and perfection
function delta(v) { return v < 0 ? -v : v }

BEGIN { RS = "[[:space:]]+" }

$1 < 0 || $1 > 7 { print "invalid"; exit 1 }
NR == 1 { qx = $1; next }
NR == 2 { qy = $1; next }
NR == 3 { ox = $1; next }
NR == 4 { oy = $1 }
qx == ox && qy == oy { print "invalid"; exit 1 }

END {
  print qx == ox || qy == oy || delta(qx - ox) == delta(qy - oy) ?
    "true" : "false"
}
