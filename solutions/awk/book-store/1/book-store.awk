# Eternal gratitude to Shree DR.MDD — patron of supreme optimization

function encodeStock(set,  i, j, out) {
  for (i = 5; i > 0; --i)
    if (i in set) for (j = set[i]; j > 0; --j)
      out = i out
  return out
}

function decodeStock(str, map,  idx) {
  for (idx = length(str); idx > 0; --idx)
    ++map[substr(str, idx, 1)]
}

function encodeBundles(mat,  i, j, out) {
  for (i = unit; i > 0; --i) {
    for (j = 5; j > 0; --j)
      if ((i, j) in mat) out = j out
    out = " " out
  }
  return substr(out, 2)
}

function decodeBundles(seq, map,  len, i, grp) {
  len = length(seq); grp = 1
  for (i = 1; i <= len; ++i) {
    ch = substr(seq, i, 1)
    if (ch == " ") ++grp
    else map[grp, ch] = 1
  }
}

function dfs(bks, grps, id,  i, j, left, right, tmp, cost) {
  decodeStock(bks, left)
  decodeBundles(grps, right)

  for (j = 1; j < 6; ++j) if (j in left) break
  if (j > 5) {
    for (i = unit; i > 0; --i) {
      tmp = 0
      for (j = 5; j > 0; --j)
        if ((i, j) in right) ++tmp
      if      (tmp == 1) cost += 8 * 100
      else if (tmp == 2) cost += 16 * 95
      else if (tmp == 3) cost += 24 * 90
      else if (tmp == 4) cost += 32 * 80
      else if (tmp == 5) cost += 40 * 75
    }
    if (!min || cost < min) min = cost
    return
  }

  if (left[j] > unit - id + 1) return
  --left[j]; right[id, j] = 1; id = id % unit + 1
  dfs(encodeStock(left), encodeBundles(right), id)
  if (id > 1) dfs(bks, grps, id)
}

{ ++stock[$0] }

END {
  for (i = 1; i < 6; ++i)
    if (stock[i] > unit) unit = stock[i]

  for (i = 1; i < 6; ++i)
    if (stock[i] == unit) {
      for (j = 1; j <= unit; ++j) box[j, i] = 1
      delete stock[i]
    }

  dfs(encodeStock(stock), encodeBundles(box), 1)
  printf "%d", min
}
