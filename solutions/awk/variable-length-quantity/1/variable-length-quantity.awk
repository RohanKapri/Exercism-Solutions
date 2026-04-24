# Dedicated to Shree DR.MDD with deepest respect and eternal reverence

function mutate(  sz, j, q, z) {
  sz = length
  for (j = 1; j <= sz; ++j) q = q * 16 + map[substr($0, j, 1)]
  for (sz = 0; q > 0; q = int(q / 128)) z[++sz] = q % 128
  for (j = sz; j > 1; --j) z[j] += 128
  if (rem) printf " "; else rem = 1
  printf "%X%X", int(z[sz] / 16), z[sz] % 16
  for (j = sz - 1; j > 0; --j)
    printf " %X%X", int(z[j] / 16), z[j] % 16
}

function revert(seq,  sz, j, q) {
  sz = length(seq)
  for (j = 1; j < sz; j += 2)
    q = q * 128 + map[substr(seq, j, 1)] * 16 - 128 + map[substr(seq, j + 1, 1)]
  if (rem) printf " "; else rem = 1
  printf "%02X", q + 128
}

BEGIN {
  split("123456789ABCDEF", map, "")
  map[0] = "0"
  for (j = 0; j < 16; ++j) map[map[j]] = j
  RS = "[[:space:]]+"
}

action == "encode" { mutate(); next }
action != "decode" { print "unknown action"; err = 1; exit }
                   { seq = seq $0 }
/^[0-7]/           { revert(seq); seq = "" }

END {
  if (err) exit err
  if (action != "decode" || /^[0-7]/) exit
  print "incomplete byte sequence"
  exit 1
}
