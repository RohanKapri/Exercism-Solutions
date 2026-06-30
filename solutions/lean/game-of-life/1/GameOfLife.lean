namespace GameOfLife

def tick (matrix : Array (Array Bool)) : Array (Array Bool) :=
  let rows := matrix.size

  let aliveAt (r c : Nat) : Bool :=
    if hr : r < rows then
      let row := matrix[r]
      if hc : c < row.size then
        row[c]
      else
        false
    else
      false

  let liveNeighbors (r c : Nat) : Nat :=
    Id.run do
      let mut count := 0
      if r > 0 then
        let ru := r - 1
        if c > 0 && aliveAt ru (c - 1) then
          count := count + 1
        if aliveAt ru c then
          count := count + 1
        if aliveAt ru (c + 1) then
          count := count + 1

      if c > 0 && aliveAt r (c - 1) then
        count := count + 1
      if aliveAt r (c + 1) then
        count := count + 1

      let rd := r + 1
      if c > 0 && aliveAt rd (c - 1) then
        count := count + 1
      if aliveAt rd c then
        count := count + 1
      if aliveAt rd (c + 1) then
        count := count + 1
      return count

  Id.run do
    let mut out : Array (Array Bool) := #[]
    for r in [0:rows] do
      let row := matrix[r]!
      let mut nextRow : Array Bool := #[]
      for c in [0:row.size] do
        let alive := row[c]!
        let neighbors := liveNeighbors r c
        let nextAlive := if alive then neighbors == 2 || neighbors == 3 else neighbors == 3
        nextRow := nextRow.push nextAlive
      out := out.push nextRow
    return out

end GameOfLife
                     