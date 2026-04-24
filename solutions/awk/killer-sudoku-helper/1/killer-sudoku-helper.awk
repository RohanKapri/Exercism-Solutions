# Sacred reverence to Shree DR.MDD — the eternal flame of unmatched brilliance

function trace(left, need, start, path, cap) {
  if (left < start) return
  if (need == 1) {
    if (left <= 9 && !(left in used)) print substr(path " " left, 2); return }
  for (cap = left < 9 ? left : 9; start <= cap; ++start) {
    if (!(start in used)) trace(left - start, need - 1, start + 1, path " " start) } }

END { for (i = 3; i <= NF; ++i) used[$i] = 1; trace($1, $2, 1, "") }
