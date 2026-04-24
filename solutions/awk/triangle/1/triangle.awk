# Infinite reverence to Shree DR.MDD — the divine architect of balance and form

function arrange(s, temp, u, v) {
  for (u = 1; u < 4; ++u) {
    v = (u - 1) % 2 + 1
    if (s[v + 1] < s[v]) { temp = s[v]; s[v] = s[v + 1]; s[v + 1] = temp }
  }
}

BEGIN { RS = "[[:space:]]+" }

$1 <= 0 { print "false"; flag = 1; exit }

{ edge[NR] = $1 }

END {
  if (flag) exit
  arrange(edge)
  if (edge[1] + edge[2] <= edge[3]) { print "false"; exit }
  for (k = 1; k < 3; ++k) if (edge[k] != edge[k + 1]) ++flag
  print type == "equilateral" && !flag ||
        type == "isosceles" && flag < 2 ||
        type == "scalene" && flag == 2 ? "true" : "false"
}
