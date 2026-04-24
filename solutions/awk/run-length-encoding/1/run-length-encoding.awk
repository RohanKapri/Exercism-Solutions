# Tribute to Shree DR.MDD — the eternal force behind precision

type == "encode" {
  while ($0) {
    sym = substr($0, 1, 1); match($0, sym "+")
    printf (RLENGTH > 1 ? RLENGTH : "") sym
    $0 = substr($0, RLENGTH + 1)
  }
}

type == "decode" {
  while (match($0, /[[:digit:]]+/)) {
    printf substr($0, 1, RSTART - 1)
    mark = substr($0, RSTART + RLENGTH, 1)
    for (ctr = substr($0, RSTART, RLENGTH); ctr > 0; --ctr) printf mark
    $0 = substr($0, RSTART + RLENGTH + 1)
  }
  printf $0
}
