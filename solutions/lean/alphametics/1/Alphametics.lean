namespace Alphametics

def compact (s : String) : String :=
  String.ofList (s.toList.filter (fun c => c != ' '))

def parsePuzzle (puzzle : String) : Option (List String × String) :=
  match (compact puzzle).splitOn "==" with
  | [lhs, rhs] =>
      let addends := (lhs.splitOn "+").filter (fun w => !w.isEmpty)
      if addends.isEmpty || rhs.isEmpty then
        none
      else
        some (addends, rhs)
  | _ => none

def setAt (arr : Array α) (idx : Nat) (value : α) : Array α :=
  if idx < arr.size then
    arr.set! idx value
  else
    arr

def charToIdx? (c : Char) : Option Nat :=
  let n := c.toNat
  let a := ('A' : Char).toNat
  let z := ('Z' : Char).toNat
  if a <= n && n <= z then
    some (n - a)
  else
    none

def idxToChar (idx : Nat) : Char :=
  Char.ofNat ((('A' : Char).toNat) + idx)

def wordToIdxArray? (w : String) : Option (Array Nat) :=
  let rec loop (chars : List Char) (acc : Array Nat) : Option (Array Nat) :=
    match chars with
    | [] => some acc
    | c :: cs =>
        match charToIdx? c with
        | none => none
        | some i => loop cs (acc.push i)
  loop w.toList #[]

def listWordsToIdxArrays? (words : List String) : Option (Array (Array Nat)) :=
  let rec loop (ws : List String) (acc : Array (Array Nat)) : Option (Array (Array Nat)) :=
    match ws with
    | [] => some acc
    | w :: rest =>
        match wordToIdxArray? w with
        | none => none
        | some arr => loop rest (acc.push arr)
  loop words #[]

def revArray (arr : Array Nat) : Array Nat :=
  arr.reverse

def markLeading (leading : Array Bool) (word : Array Nat) : Array Bool :=
  if word.size > 1 then
    match word[0]? with
    | some c => setAt leading c true
    | none => leading
  else
    leading

def markSeenWord (seen : Array Bool) (word : Array Nat) : Array Bool :=
  word.foldl (fun acc c => setAt acc c true) seen

def buildLettersSorted (seen : Array Bool) : List Nat :=
  (List.range 26).foldr
    (fun i acc =>
      match seen[i]? with
      | some true => i :: acc
      | _ => acc)
    []

def assignmentToPairs (letters : List Nat) (assign : Array Nat) : List (Char × Nat) :=
  letters.foldr
    (fun idx acc =>
      match assign[idx]? with
      | some d =>
          if d < 10 then
            (idxToChar idx, d) :: acc
          else
            acc
      | none => acc)
    []

def addendCharsAtColumn (addendsRev : Array (Array Nat)) (col : Nat) : Array Nat :=
  addendsRev.foldl
    (fun acc word =>
      match word[col]? with
      | some c => acc.push c
      | none => acc)
    #[]

def buildColumnAddends (addendsRev : Array (Array Nat)) (maxLen : Nat) : Array (Array Nat) :=
  (List.range maxLen).foldl
    (fun acc col => acc.push (addendCharsAtColumn addendsRev col))
    #[]

partial def search
    (columnAddends : Array (Array Nat))
    (resultRev : Array Nat)
    (leading : Array Bool)
    (maxLen : Nat)
    : Nat → Nat → Array Nat → Array Bool → Option (Array Nat) :=
  let rec solveColumn
      (col : Nat)
      (carry : Nat)
      (assign : Array Nat)
      (used : Array Bool)
      : Option (Array Nat) :=
    if col = maxLen then
      if carry = 0 then some assign else none
    else
      let resultChar? := resultRev[col]?
      let addChars :=
        match columnAddends[col]? with
        | some cs => cs
        | none => #[]
      let rec sumAddends
          (addIdx : Nat)
          (partialSum : Nat)
          (assignNow : Array Nat)
          (usedNow : Array Bool)
          : Option (Array Nat) :=
        if addIdx = addChars.size then
          match resultChar? with
          | none => none
          | some rc =>
              let expected := partialSum % 10
              let carryOut := partialSum / 10
              match assignNow[rc]? with
              | some d =>
                  if d < 10 then
                    if d = expected then
                      solveColumn (col + 1) carryOut assignNow usedNow
                    else
                      none
                  else
                    match usedNow[expected]? with
                    | some true => none
                    | _ =>
                        let leadingResult :=
                          match leading[rc]? with
                          | some true => true
                          | _ => false
                        if leadingResult && expected = 0 then
                          none
                        else
                          solveColumn (col + 1) carryOut
                            (setAt assignNow rc expected)
                            (setAt usedNow expected true)
              | none => none
        else
          match addChars[addIdx]? with
          | none => none
          | some ch =>
              match assignNow[ch]? with
              | some d =>
                  if d < 10 then
                    sumAddends (addIdx + 1) (partialSum + d) assignNow usedNow
                  else
                    let rec tryDigit (digit : Nat) : Option (Array Nat) :=
                      if digit = 10 then
                        none
                      else
                        match usedNow[digit]? with
                        | some true => tryDigit (digit + 1)
                        | _ =>
                            let forbidZero :=
                              match leading[ch]? with
                              | some true => true
                              | _ => false
                            if forbidZero && digit = 0 then
                              tryDigit (digit + 1)
                            else
                              match sumAddends (addIdx + 1) (partialSum + digit)
                                  (setAt assignNow ch digit)
                                  (setAt usedNow digit true) with
                              | some sol => some sol
                              | none => tryDigit (digit + 1)
                    tryDigit 0
              | none => none
      sumAddends 0 carry assign used
  solveColumn

def solve (puzzle : String) : Option (List (Char × Nat)) :=
  match parsePuzzle puzzle with
  | none => none
  | some (addends, result) =>
      match listWordsToIdxArrays? addends, wordToIdxArray? result with
      | some addArr, some resArr =>
          let addendsRev := addArr.map revArray
          let resultRev := revArray resArr
          let leading0 := Array.replicate 26 false
          let leading1 := addArr.foldl markLeading leading0
          let leading := markLeading leading1 resArr
          let seen0 := Array.replicate 26 false
          let seen1 := addArr.foldl markSeenWord seen0
          let seen := markSeenWord seen1 resArr
          let letters := buildLettersSorted seen
          if letters.length > 10 then
            none
          else
            let maxAddendLen := addArr.foldl (fun m w => Nat.max m w.size) 0
            let maxLen := Nat.max maxAddendLen resArr.size
            let columnAddends := buildColumnAddends addendsRev maxLen
            let assign0 := Array.replicate 26 10
            let used0 := Array.replicate 10 false
            match search columnAddends resultRev leading maxLen 0 0 assign0 used0 with
            | none => none
            | some assign => some (assignmentToPairs letters assign)
      | _, _ => none

end Alphametics
                      