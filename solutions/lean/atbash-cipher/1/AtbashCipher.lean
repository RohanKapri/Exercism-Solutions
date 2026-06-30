namespace AtbashCipher

private def a : Nat := 'a'.toNat
private def z : Nat := 'z'.toNat

private def cipher (c : Char) : Option Char := do
  guard c.isAlphanum
  if c.isDigit
  then return c
  else
    let offset := c.toLower.toNat - a
    return Char.ofNat (z - offset)

def encode (phrase : String) : String :=
  let (encoded, _) := phrase.foldl (fun (acc, count) c =>
    match cipher c with
    | none   => (acc, count)
    | some x =>
      if count = 5
      then (acc.push ' ' |>.push x, 1)
      else (acc.push x, count + 1)
  ) (init := ("", 0))
  encoded

def decode (phrase : String) : String :=
  phrase.foldl (fun acc c =>
    cipher c |>.map acc.push |>.getD acc
  ) (init := "")

end AtbashCipher