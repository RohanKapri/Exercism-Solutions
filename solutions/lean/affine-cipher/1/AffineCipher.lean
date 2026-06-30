namespace AffineCipher

private def alphabetSize : Nat := 26

private def lowerA : Nat := 'a'.toNat
private def lowerZ : Nat := 'z'.toNat
private def upperA : Nat := 'A'.toNat
private def upperZ : Nat := 'Z'.toNat
private def digit0 : Nat := '0'.toNat
private def digit9 : Nat := '9'.toNat

private def isCoprimeToAlphabet (a : Nat) : Bool :=
  Nat.gcd a alphabetSize == 1

private def modInverse (a : Nat) : Option Nat :=
  if !isCoprimeToAlphabet a then
    none
  else
    Id.run <| do
      let mut candidate := 0
      while candidate < alphabetSize do
        if (a * candidate) % alphabetSize == 1 then
          return some candidate
        candidate := candidate + 1
      return none

@[inline] private def asciiToLower (value : Nat) : Nat :=
  if upperA <= value && value <= upperZ then value + (lowerA - upperA) else value

private def encodeBytes (bytes : ByteArray) (a : Nat) (bMod : Nat) : String :=
  let out := Id.run <| do
    let mut out : ByteArray := ByteArray.emptyWithCapacity (bytes.size + bytes.size / 5)
    let mut i := 0
    let mut groupLen := 0
    while i < bytes.size do
      let lowered := asciiToLower (bytes[i]!.toNat)
      if lowerA <= lowered && lowered <= lowerZ then
        if groupLen == 5 then
          out := out.push ' '.toUInt8
          groupLen := 0
        let encoded := lowerA + ((a * (lowered - lowerA) + bMod) % alphabetSize)
        out := out.push (UInt8.ofNat encoded)
        groupLen := groupLen + 1
      else if digit0 <= lowered && lowered <= digit9 then
        if groupLen == 5 then
          out := out.push ' '.toUInt8
          groupLen := 0
        out := out.push (UInt8.ofNat lowered)
        groupLen := groupLen + 1
      i := i + 1
    return out
  String.fromUTF8! out

private def decodeBytes (bytes : ByteArray) (inverseA : Nat) (bMod : Nat) : String :=
  let out := Id.run <| do
    let mut out : ByteArray := ByteArray.emptyWithCapacity bytes.size
    let mut i := 0
    while i < bytes.size do
      let lowered := asciiToLower (bytes[i]!.toNat)
      if lowerA <= lowered && lowered <= lowerZ then
        let shifted := (lowered - lowerA + alphabetSize - bMod) % alphabetSize
        let decoded := lowerA + ((inverseA * shifted) % alphabetSize)
        out := out.push (UInt8.ofNat decoded)
      else if digit0 <= lowered && lowered <= digit9 then
        out := out.push (UInt8.ofNat lowered)
      i := i + 1
    return out
  String.fromUTF8! out

def encode (phrase : String) (a : Nat) (b : Nat) : Option String :=
  if !isCoprimeToAlphabet a then
    none
  else
    some (encodeBytes phrase.toUTF8 a (b % alphabetSize))

def decode (phrase : String) (a : Nat) (b : Nat) : Option String :=
  match modInverse a with
  | none => none
  | some inverseA =>
    some (decodeBytes phrase.toUTF8 inverseA (b % alphabetSize))

end AffineCipher