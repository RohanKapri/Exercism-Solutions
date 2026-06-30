namespace CryptoSquare

private def normalize (plaintext : String) : Array Char :=
  plaintext.foldl (fun acc ch =>
    let lc := ch.toLower
    if lc.isAlphanum then acc.push lc else acc
  ) #[]

private def ceilSqrt (n : Nat) : Nat :=
  let rec go (k fuel : Nat) : Nat :=
    if k * k >= n then k
    else
      match fuel with
      | 0 => k
      | fuel + 1 => go (k + 1) fuel
  go 0 (n + 1)

def ciphertextBaseline (plaintext : String) : String :=
  let normalizedList :=
    let revChars := plaintext.toList.foldl (fun acc ch =>
      let lc := ch.toLower
      if lc.isAlphanum then lc :: acc else acc
    ) []
    revChars.reverse
  let n := normalizedList.length
  if n == 0 then
    ""
  else
    let c := ceilSqrt n
    let r := (n + c - 1) / c
    let chunks := (List.range c).map (fun col =>
      let chars := (List.range r).map (fun row =>
        let idx := row * c + col
        match normalizedList.drop idx with
        | ch :: _ => ch
        | [] => ' ')
      String.ofList chars)
    String.intercalate " " chunks

def ciphertext (plaintext : String) : String :=
  let normalized := normalize plaintext
  let n := normalized.size
  if n == 0 then
    ""
  else
    let c := ceilSqrt n
    let r := (n + c - 1) / c
    let chunks : Array String := Id.run <| do
      let mut chunks : Array String := Array.mkEmpty c
      for col in [0:c] do
        let mut chars : Array Char := Array.mkEmpty r
        for row in [0:r] do
          let idx := row * c + col
          chars := chars.push (normalized[idx]?.getD ' ')
        chunks := chunks.push (String.ofList chars.toList)
      return chunks
    String.intercalate " " chunks.toList

end CryptoSquare