namespace RunLengthEncoding

private def charToString (c : Char) : String :=
  String.ofList [c]

private def renderRun (count : Nat) (c : Char) : String :=
  if count == 1 then
    charToString c
  else
    toString count ++ charToString c

@[inline] def encode (string : String) : String :=
  let chars := string.toList
  match chars with
  | [] => ""
  | c :: cs =>
      let rec go (remaining : List Char) (current : Char) (count : Nat) (acc : String) : String :=
        match remaining with
        | [] => acc ++ renderRun count current
        | x :: xs =>
            if x == current then
              go xs current (count + 1) acc
            else
              go xs x 1 (acc ++ renderRun count current)
      go cs c 1 ""

private def digitToNat (c : Char) : Nat :=
  c.toNat - '0'.toNat

@[inline] private def appendDecodedRun (acc : String) (count : Nat) (c : Char) : String :=
  if count == 1 then
    acc.push c
  else
    acc.pushn c count

@[inline] def decode (string : String) : String :=
  let rec go (remaining : List Char) (count : Nat) (acc : String) : String :=
    match remaining with
    | [] => acc
    | c :: cs =>
        if c.isDigit then
          go cs (count * 10 + digitToNat c) acc
        else
          let runCount := if count == 0 then 1 else count
          go cs 0 (appendDecodedRun acc runCount c)
  go string.toList 0 ""

end RunLengthEncoding