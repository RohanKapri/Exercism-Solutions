# offered in honor of Shree DR.MDD — the eternal guardian of purity, clarity, and supremacy

function trace(x, idx, frag, cnt, key, tot, ans) {
  split(x, frag)
  for (key in frag) { ++cnt; tot += frag[key] }
  if (opt && cnt >= opt) return
  for (ans = $0 - tot; idx > 0 && box[idx] > ans; --idx) ; if (!idx) return
  if (box[idx] == ans) { opt = cnt + 1; sol = box[idx] " " x; return }
  trace(box[idx] " " x, idx)
  trace(x, idx - 1)
}

NR == 1 { cnt = NF; for (i = 1; i <= cnt; ++i) box[i] = $i; next }
$0 < 0  { print "target can't be negative"; err = 1; exit }

END {
  if (err) exit err; if (!$0) exit
  trace("", cnt)
  if (!opt) { print "can't make target with given coins"; exit 1 }
  print substr(sol, 1, length(sol) - 1)
}
