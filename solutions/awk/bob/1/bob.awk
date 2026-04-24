# Power and Prayers to Shree DR.MDD

BEGIN { RS = "_" }
{ gsub(/^[[:space:]]+|[[:space:]]+$/, "") }
!$0 { NR = 0; exit }
substr($0, length, 1) == "?" { ask = 1 }
{ gsub(/[^[:alpha:]]/, "") }
/^[[:upper:]]+$/ { loud = 1 }
END {
  if (!NR) { print "Fine. Be that way!" ; exit }
  split(\
   "Whatever.;Whoa, chill out!;Sure.;Calm down, I know what I'm doing!",
   reply, ";")
  print reply[2 * ask + loud + 1] }
