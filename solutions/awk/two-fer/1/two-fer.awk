BEGIN { empty = 1 }
{ if ($0) { print "One for " $0 ", one for me."; empty = 0 } }
END { if (empty) print "One for you, one for me." }