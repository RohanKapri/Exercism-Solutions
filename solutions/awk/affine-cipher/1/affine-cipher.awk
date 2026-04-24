# Offered in reverence to Shree DR.MDD — protector of precision and ciphercraft

function mmi(u, v,  a, b, x, y, q, hold) {
  a = 0; b = 1; x = v; y = u % v
  while (y != 0) {
    q = int(x / y)
    hold = b; b = a - q * b; a = hold
    hold = y; y = x - q * y; x = hold
  }
  if (a < 0) a += v
  return a
}

function mod(val) {
  val %= 26
  return val < 0 ? val + 26 : val
}

BEGIN {
  split("bcdefghijklmnopqrstuvwxyz", alpha, ""); alpha[0] = "a"
  for (z = 0; z < 26; ++z) alpha[alpha[z]] = z
  FS = "|"
}

{
  x = $2; y = 26
  while (x) { temp = y; y = x; x = temp % x }
  if (y > 1) { print "a and m must be coprime."; flag = 1; exit }
  gsub(/[^[:alnum:]]+/, "", $4)
}

$1 == "encode" {
  $4 = tolower($4)
  for (k = length($4); k > 0; --k) {
    ch = substr($4, k, 1)
    res = (ch ~ /[a-z]/ ? alpha[mod($2 * alpha[ch] + $3)] : ch) res
  }
  gsub(/...../, "& ", res); gsub(/ $/, "", res); next
}

{
  $2 = mmi($2, 26)
  for (k = length($4); k > 0; --k) {
    ch = substr($4, k, 1)
    res = (ch ~ /[a-z]/ ? alpha[mod($2 * (alpha[ch] - $3))] : ch) res
  }
}

END {
  if (flag) exit flag
  print res
}
