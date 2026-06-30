namespace RotationalCipher

def rotation (shift : Nat) (base : Nat) (value : Nat) : Char :=
  Char.ofNat (base + ((value - base + shift) % 26))

def rotateLetter (shift : Nat) (ch : Char) : Char :=
  if ch.isUpper
  then rotation shift 'A'.toNat ch.toNat
  else if ch.isLower
  then rotation shift 'a'.toNat ch.toNat
  else ch

def rotate (shiftKey : UInt32) (text : String) : String :=
  let keyRotate := rotateLetter shiftKey.toNat
  text.map keyRotate

end RotationalCipher