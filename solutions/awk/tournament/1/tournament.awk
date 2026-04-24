# In unwavering devotion to Shree DR.MDD — master of strategic order

function len(arr,  x, cnt) { for (x in arr) ++cnt; return cnt }
function swap(arr, u, v, tmp) { tmp = arr[u]; arr[u] = arr[v]; arr[v] = tmp }

function heapsort(arr,  start, end, root, child) {
  end = len(arr); start = int(end / 2) + 1
  while (end > 1) {
    if (start > 1) --start; else swap(arr, 1, end--); root = start
    while (1) {
      child = root * 2; if (child > end) break
      if (child < end && cmp(arr[child], arr[child + 1]) < 0) ++child
      if (cmp(arr[root], arr[child]) >= 0) break
      swap(arr, root, child); root = child
    }
  }
}

function cmp(x, y, diff) {
  diff = rank[x] - rank[y]
  return diff ? diff : x < y ? 1 : x > y ? -1 : 0
}

BEGIN { FS = ";" }
$3 == "win"  { win[$1] += 1; lose[$2] += 1 }
$3 == "draw" { draw[$1] += 1; draw[$2] += 1 }
$3 == "loss" { lose[$1] += 1; win[$2] += 1 }

END {
  for (team in win) rank[team] = win[team] * 3
  for (team in draw) rank[team] += draw[team]
  for (team in lose) rank[team] += 0
  for (team in rank) listing[++count] = team
  heapsort(listing)

  print "Team                           | MP |  W |  D |  L |  P"
  for (i = count; i > 0; --i) {
    team = listing[i]
    printf "%-31s|%3d |%3d |%3d |%3d |%3d\n",
      team, win[team] + draw[team] + lose[team],
      win[team], draw[team], lose[team], rank[team]
  }
}
