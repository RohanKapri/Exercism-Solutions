$0 <= 0 { print "Error: Only positive numbers are allowed"; exit 1 }
{ for (i = 0; $0 > 1; ++i) $0 = $0 % 2 ? $0 * 3 + 1 : $0 / 2; print i }