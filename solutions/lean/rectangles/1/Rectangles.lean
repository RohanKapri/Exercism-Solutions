namespace Rectangles

private def isHorizontalChar (ch : Char) : Bool :=
  ch = '+' || ch = '-'

private def isVerticalChar (ch : Char) : Bool :=
  ch = '+' || ch = '|'

private def buildRowBadPrefix (grid : Array (Array Char)) (cols : Nat) : Array (Array Nat) :=
  grid.map fun row =>
    Id.run do
      let mut pref : Array Nat := #[0]
      let mut bad := 0
      for c in [0:cols] do
        let ch := row[c]!
        if !(isHorizontalChar ch) then
          bad := bad + 1
        pref := pref.push bad
      return pref

private def buildColBadPrefix (grid : Array (Array Char)) (rows cols : Nat) : Array (Array Nat) :=
  Id.run do
    let mut prefixes : Array (Array Nat) := #[]
    for c in [0:cols] do
      let mut pref : Array Nat := #[0]
      let mut bad := 0
      for r in [0:rows] do
        let ch := grid[r]![c]!
        if !(isVerticalChar ch) then
          bad := bad + 1
        pref := pref.push bad
      prefixes := prefixes.push pref
    return prefixes

private def segmentValid (pref : Array Nat) (start stop : Nat) : Bool :=
  pref[stop + 1]! - pref[start]! = 0

def rectangles (strings : Array String) : Nat :=
  let rows := strings.size
  let cols := match strings[0]? with
    | some row => row.length
    | none => 0

  if rows < 2 || cols < 2 then
    0
  else
    let grid : Array (Array Char) := strings.map (fun s => s.toList.toArray)
    let rowBadPrefix := buildRowBadPrefix grid cols
    let colBadPrefix := buildColBadPrefix grid rows cols

    Id.run do
      let mut total := 0
      for r1 in [0:rows] do
        let row1 := grid[r1]!
        let row1Pref := rowBadPrefix[r1]!
        for r2 in [r1 + 1:rows] do
          let row2 := grid[r2]!
          let row2Pref := rowBadPrefix[r2]!

          let mut colsWithValidCorners : Array Nat := #[]
          for c in [0:cols] do
            if row1[c]! = '+' && row2[c]! = '+' && segmentValid (colBadPrefix[c]!) r1 r2 then
              colsWithValidCorners := colsWithValidCorners.push c

          let n := colsWithValidCorners.size
          for i in [0:n] do
            let c1 := colsWithValidCorners[i]!
            for j in [i + 1:n] do
              let c2 := colsWithValidCorners[j]!
              if segmentValid row1Pref c1 c2 && segmentValid row2Pref c1 c2 then
                total := total + 1
      return total

end Rectangles