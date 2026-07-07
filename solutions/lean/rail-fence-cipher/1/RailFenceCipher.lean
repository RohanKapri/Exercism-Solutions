namespace RailFenceCipher

def Positive := { x : Nat // x > 0 }

private def stepRail (railCount rail : Nat) (down : Bool) : Nat × Bool :=
  if railCount ≤ 1 then
    (0, true)
  else if down then
    if rail + 1 < railCount then
      (rail + 1, true)
    else
      (rail - 1, false)
  else if rail == 0 then
    (1, true)
  else
    (rail - 1, false)

private def toCharArray (s : String) : Array Char :=
  s.foldl (fun acc c => acc.push c) #[]

def encode (rails : Positive) (msg : String) : String :=
  let railCount := rails.val
  if railCount ≤ 1 then
    msg
  else
    let initRows : Array (Array Char) := Array.replicate railCount #[]
    let (rows, _, _) := msg.foldl
      (fun (state : Array (Array Char) × Nat × Bool) c =>
        let (rows, rail, down) := state
        let rows := rows.set! rail ((rows[rail]!).push c)
        let (nextRail, nextDown) := stepRail railCount rail down
        (rows, nextRail, nextDown))
      (initRows, 0, true)
    let out := rows.foldl (fun acc row => acc ++ row) #[]
    String.ofList out.toList

def decode (rails : Positive) (msg : String) : String :=
  let railCount := rails.val
  if railCount ≤ 1 then
    msg
  else
    let chars := toCharArray msg
    let n := chars.size

    let counts : Array Nat := Id.run do
      let mut counts := Array.replicate railCount 0
      let mut rail := 0
      let mut down := true
      let mut i := 0
      while i < n do
        counts := counts.set! rail (counts[rail]! + 1)
        let next := stepRail railCount rail down
        rail := next.1
        down := next.2
        i := i + 1
      return counts

    let rows : Array (Array Char) := Id.run do
      let mut rows : Array (Array Char) := Array.replicate railCount #[]
      let mut offset := 0
      let mut r := 0
      while r < railCount do
        let len := counts[r]!
        let mut row : Array Char := Array.mkEmpty len
        let mut j := 0
        while j < len do
          row := row.push chars[offset + j]!
          j := j + 1
        rows := rows.set! r row
        offset := offset + len
        r := r + 1
      return rows

    let out : Array Char := Id.run do
      let mut cursors := Array.replicate railCount 0
      let mut out : Array Char := Array.mkEmpty n
      let mut rail := 0
      let mut down := true
      let mut i := 0
      while i < n do
        let idx := cursors[rail]!
        out := out.push (rows[rail]![idx]!)
        cursors := cursors.set! rail (idx + 1)
        let next := stepRail railCount rail down
        rail := next.1
        down := next.2
        i := i + 1
      return out

    String.ofList out.toList

end RailFenceCipher