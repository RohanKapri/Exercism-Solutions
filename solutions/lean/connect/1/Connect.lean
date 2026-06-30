namespace Connect

def parseRow (line : String) : Array Char :=
  (line.toList.filter fun ch => ch == 'X' || ch == 'O' || ch == '.') |>.toArray

def getCell? (grid : Array (Array Char)) (r c : Nat) : Option Char := do
  let row <- grid[r]?
  row[c]?

private def initialVisited (grid : Array (Array Char)) : Array (Array Bool) :=
  grid.map (fun row => Array.replicate row.size false)

private def markVisited
    (visited : Array (Array Bool))
    (r c : Nat) : Array (Array Bool) :=
  let row := visited[r]!
  visited.set! r (row.set! c true)

private def isVisited
    (visited : Array (Array Bool))
    (r c : Nat) : Bool :=
  (visited[r]!)[c]!

private def addIfUnseenPlayer
    (grid : Array (Array Char))
    (player : Char)
    (r c : Nat)
    (visited : Array (Array Bool))
    (stack : Array (Nat × Nat)) : Array (Array Bool) × Array (Nat × Nat) :=
  match getCell? grid r c with
  | some ch =>
      if ch == player && !(isVisited visited r c) then
        let visited := markVisited visited r c
        (visited, stack.push (r, c))
      else
        (visited, stack)
  | none =>
      (visited, stack)

private def playerWins
    (grid : Array (Array Char))
    (player : Char)
    (goal : Nat → Nat → Bool)
    (seedTop : Bool) : Bool :=
  let rows := grid.size
  Id.run do
    let mut visited := initialVisited grid
    let mut stack : Array (Nat × Nat) := #[]

    if seedTop then
      match grid[0]? with
      | some row =>
          for c in [0:row.size] do
            if row[c]! == player then
              visited := markVisited visited 0 c
              stack := stack.push (0, c)
      | none =>
          pure ()
    else
      for r in [0:rows] do
        match getCell? grid r 0 with
        | some ch =>
            if ch == player then
              visited := markVisited visited r 0
              stack := stack.push (r, 0)
        | none =>
            pure ()

    let mut found := false
    while (!found) && stack.size > 0 do
      let idx := stack.size - 1
      let (r, c) := stack[idx]!
      stack := stack.pop

      if goal r c then
        found := true
      else
        if r > 0 then
          let (visited1, stack1) := addIfUnseenPlayer grid player (r - 1) c visited stack
          let (visited2, stack2) := addIfUnseenPlayer grid player (r - 1) (c + 1) visited1 stack1
          visited := visited2
          stack := stack2

        if c > 0 then
          let (visited1, stack1) := addIfUnseenPlayer grid player r (c - 1) visited stack
          let (visited2, stack2) := addIfUnseenPlayer grid player (r + 1) (c - 1) visited1 stack1
          visited := visited2
          stack := stack2

        let (visited1, stack1) := addIfUnseenPlayer grid player r (c + 1) visited stack
        let (visited2, stack2) := addIfUnseenPlayer grid player (r + 1) c visited1 stack1
        visited := visited2
        stack := stack2

    return found

def oWins (grid : Array (Array Char)) : Bool :=
  let height := grid.size
  playerWins grid 'O' (fun r _ => r + 1 == height) true

def xWins (grid : Array (Array Char)) : Bool :=
  playerWins grid 'X'
    (fun r c =>
      match grid[r]? with
      | some row => c + 1 == row.size
      | none => false)
    false

def winner (board : Array String) : Char :=
  let grid := board.map parseRow
  if xWins grid then 'X' else if oWins grid then 'O' else ' '

end Connect