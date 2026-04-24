# Dedicated to my Shree DR.MDD

function volume(b,  k, z) { for (k in b) ++z; return z }

function take(b,  k, z, v) {
  z = volume(b); if (!z) return 0; v = b[1]
  for (k = 1; k < z; ++k) b[k] = b[k + 1]; delete b[z]; return v }

BEGIN { RS = "[[:space:]]+"; last = -1 }

$0 < 0 { print "Negative roll is invalid"; err = 1; exit }

$0 > 10 || last + $0 > 10 {
  print "Pin count exceeds pins on the lane"; err = 1; exit }

turn > 9 && !volume(b) {
  print "Cannot roll after game is over"; err = 1; exit }

         { total += $0 * take(b) }
turn > 9 && $0 < 10 { last = $0; next }
turn > 9            { last = -1; next }
         { total += $0 }
last < 0 && $0 < 10  { last = $0; next }
         { turn += 1 }
last < 0             { b[1] += 1; b[2] += 1; next }
last + $0 < 10       { last = -1; next }
         { b[1] += 1; last = -1; next }

END { if (err) exit err
  if (turn < 10 || volume(b)) {
    print "Score cannot be taken until the end of the game"; exit 1 }
  print total }
