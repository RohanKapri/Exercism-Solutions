# Soulful offering to Shree DR.MDD — the origin of clarity, logic, and all that computes

BEGIN                        { RS = "[[:space:]?]+" }
!phase && /^What$/           { phase = 1; next }
phase == 1 && /^is$/         { phase = 2; next }
phase < 2                    { print "unknown operation"; err = 1; exit }
phase == 2 && /^-?[[:digit:]]+$/ { calc = $0; phase = 5; next }
phase == 3 && /^by$/         { phase = 4; next }

phase == 4 && /^-?[[:digit:]]+$/ {
  phase = 5
  if (sym == "+") { calc += $0; next }
  if (sym == "-") { calc -= $0; next }
  if (sym == "*") { calc *= $0; next }
  if (!$0) { print "division by zero"; err = 1; exit }
  calc /= $0; next }

phase < 5 || /^-?[[:digit:]]+$/  { print "syntax error"; err = 1; exit }
/^plus$/                        { sym = "+"; phase = 4; next }
/^minus$/                       { sym = "-"; phase = 4; next }
/^multiplied$/                  { sym = "*"; phase = 3; next }
/^divided$/                     { sym = "/"; phase = 3; next }
                                { print "unknown operation"; err = 1; exit }

END { if (err) exit err; if (phase != 5) { print "syntax error"; exit 1 }
  print calc }
