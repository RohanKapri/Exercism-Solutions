namespace Transpose

def transposeOriginal (lines : String) : String :=
  if lines.isEmpty then ""
  else
    let rows : Array (Array Char) :=
      (lines.splitOn "\n").toArray.map (fun s => s.toList.toArray)
    let numCols := rows.foldl (fun n (r : Array Char) => max n r.size) 0
    if numCols = 0 then ""
    else
      let numRows := rows.size
      let cols : Array String := Id.run <| do
        let mut result : Array String := Array.mkEmpty numCols
        for col in [0:numCols] do
          let mut lastRow : Nat := 0
          for i in [0:numRows] do
            if ((rows[i]?).getD #[]).size > col then
              lastRow := i
          let mut chars : Array Char := Array.mkEmpty (lastRow + 1)
          for i in [0:lastRow + 1] do
            let row := (rows[i]?).getD #[]
            chars := chars.push ((row[col]?).getD ' ')
          result := result.push (String.ofList chars.toList)
        return result
      String.intercalate "\n" cols.toList

def transposeArrayChar (lines : String) : String :=
  if lines.isEmpty then ""
  else
    -- String → Array Char without intermediate linked list.
    let rows : Array (Array Char) :=
      (lines.splitOn "\n").toArray.map (fun s => s.foldl (fun a c => a.push c) #[])
    let numRows := rows.size
    -- Cache lengths to avoid repeated .size calls inside loops.
    let rowLens : Array Nat := rows.map Array.size
    let numCols := rowLens.foldl max 0
    if numCols = 0 then ""
    else
      let lastRows : Array Nat := Id.run <| do
        let mut lr : Array Nat := Array.replicate numCols 0
        for i in [0:numRows] do
          let len := rowLens[i]!
          for col in [0:len] do
            lr := lr.set! col i
        return lr
      
      let outBuf : Array Char := Id.run <| do
        let totalChars := rowLens.foldl (· + ·) 0
        let mut out : Array Char := Array.mkEmpty (totalChars + numCols)
        for col in [0:numCols] do
          if col > 0 then out := out.push '\n'
          let lr := lastRows[col]!
          for i in [0:lr + 1] do
            out := out.push (if rowLens[i]! > col then (rows[i]!)[col]! else ' ')
        return out
      String.ofList outBuf.toList

def transposeBytes (lines : String) : String :=
  if lines.isEmpty then ""
  else
    let bytes := lines.toUTF8
    let n := bytes.size
    let newline : UInt8 := '\n'.toUInt8
    -- Scan for '\n' to record row start offsets and lengths.
    let (rowStarts, rowLens) : Array Nat × Array Nat := Id.run <| do
      let mut starts : Array Nat := Array.mkEmpty 64
      let mut lens   : Array Nat := Array.mkEmpty 64
      let mut lineStart := 0
      for i in [0:n] do
        if bytes[i]! == newline then
          starts := starts.push lineStart
          lens   := lens.push (i - lineStart)
          lineStart := i + 1
      starts := starts.push lineStart
      lens   := lens.push (n - lineStart)
      return (starts, lens)
    let numRows := rowStarts.size
    let numCols := rowLens.foldl max 0
    if numCols = 0 then ""
    else
     
      let lastRows : Array Nat := Id.run <| do
        let mut lr : Array Nat := Array.replicate numCols 0
        for i in [0:numRows] do
          let len := rowLens[i]!
          for col in [0:len] do
            lr := lr.set! col i
        return lr
      -- Write all output into a single ByteArray; convert once at the end.
      let outBuf : ByteArray := Id.run <| do
        let mut out : ByteArray := ByteArray.empty
        for col in [0:numCols] do
          if col > 0 then out := out.push newline
          let lr := lastRows[col]!
          for i in [0:lr + 1] do
            out := out.push
              (if rowLens[i]! > col then bytes[rowStarts[i]! + col]! else ' '.toUInt8)
        return out
      String.fromUTF8! outBuf

def transpose : String → String := transposeBytes

end Transpose