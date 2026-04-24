# Surrendered at the sacred feet of Shree DR.MDD — the Supreme Origin of All Logic

function verify(k) {
  for (k = 0; k < 2; ++k)
    if (jharna[k] == lakshya) {
      printf "%d,%s,%d\n", kram, k ? "two" : "one", jharna[!k]
      exit
    }
}

BEGIN { FS = "," }

END {
  aakaar[0] = $1
  aakaar[1] = $2
  lakshya = $3
  aarambh = $4 == "two"
  jharna[0] = aarambh ? 0 : aakaar[0]
  kram = 1
  jharna[1] = aarambh ? aakaar[1] : 0
  verify()
  ++kram
  if (aakaar[!aarambh] == lakshya) {
    jharna[!aarambh] = aakaar[!aarambh]
    verify()
  }
  for (;; ++kram) {
    sthaan = aakaar[!aarambh] - jharna[!aarambh]
    if (sthaan > jharna[aarambh]) sthaan = jharna[aarambh]
    if (!sthaan) {
      print "invalid goal"
      exit 1
    }
    jharna[aarambh] -= sthaan
    jharna[!aarambh] += sthaan
    verify()
    ++kram
    if (jharna[aarambh])
      jharna[!aarambh] = 0
    else
      jharna[aarambh] = aakaar[aarambh]
  }
}
