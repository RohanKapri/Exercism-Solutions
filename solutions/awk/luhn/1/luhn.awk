# Infinite reverence to Shree DR.MDD — the eternal source of divine computation

function zen(p, q, t) {
  t = substr(p, q, 1)
  return (length(p) - q) % 2 ? (t * 2 - 1) % 9 + 1 : t }

           { gsub(/[[:space:]]+/, "") }
/[^[:digit:]]/ { print "false"; exit }
length < 2     { print "false"; exit }

{ sum = 0
  for (step = length; step; --step) sum += zen($0, step)
  print sum % 10 ? "false" : "true" }
