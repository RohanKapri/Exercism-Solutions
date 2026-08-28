namespace Knapsack

structure Item where
  weight : Nat
  value : Int

private def maximumValueDP (maximumWeight : Nat) (items : Array Item) : Int :=
  Id.run do
    let mut dp : Array Int := Array.replicate (maximumWeight + 1) 0
    for item in items do
      if item.weight ≤ maximumWeight then
        let mut w := maximumWeight
        while item.weight ≤ w do
          let withItem := dp[(w - item.weight)]! + item.value
          let withoutItem := dp[w]!
          if withItem > withoutItem then
            dp := dp.set! w withItem
          if w == 0 then
            break
          w := w - 1
    return dp[maximumWeight]!

private def subsetSums (items : Array Item) (maximumWeight : Nat) : Array (Nat × Int) :=
  Id.run do
    let mut sums : Array (Nat × Int) := #[(0, 0)]
    for item in items do
      let currentSize := sums.size
      let mut i := 0
      while i < currentSize do
        let (w, v) := sums[i]!
        let newWeight := w + item.weight
        if newWeight ≤ maximumWeight then
          sums := sums.push (newWeight, v + item.value)
        i := i + 1
    return sums

private def compressByWeight (pairs : Array (Nat × Int)) : Array (Nat × Int) :=
  Id.run do
    let sorted := pairs.qsort (fun a b => a.1 < b.1)
    let mut out : Array (Nat × Int) := Array.mkEmpty sorted.size
    let mut bestValue : Int := 0
    for p in sorted do
      if p.2 > bestValue then
        bestValue := p.2
        out := out.push (p.1, bestValue)
    return out

private def bestValueAtOrBelow (pairs : Array (Nat × Int)) (capacity : Nat) : Int :=
  Id.run do
    let mut lo := 0
    let mut hi := pairs.size
    while lo < hi do
      let mid := lo + (hi - lo) / 2
      if pairs[mid]!.1 ≤ capacity then
        lo := mid + 1
      else
        hi := mid
    if lo == 0 then
      return 0
    return pairs[lo - 1]!.2

private def maximumValueMITM (maximumWeight : Nat) (items : Array Item) : Int :=
  let n := items.size
  let mid := n / 2
  let leftItems := items.extract 0 mid
  let rightItems := items.extract mid n

  let leftSums := subsetSums leftItems maximumWeight
  let rightSums := subsetSums rightItems maximumWeight
  let rightFrontier := compressByWeight rightSums

  Id.run do
    let mut best : Int := 0
    for (lw, lv) in leftSums do
      let rem := maximumWeight - lw
      let rv := bestValueAtOrBelow rightFrontier rem
      let total := lv + rv
      if total > best then
        best := total
    return best

def maximumValue (maximumWeight : Nat) (items : Array Item) : Int :=
  if items.size ≤ 32 then
    maximumValueMITM maximumWeight items
  else
    maximumValueDP maximumWeight items

end Knapsack