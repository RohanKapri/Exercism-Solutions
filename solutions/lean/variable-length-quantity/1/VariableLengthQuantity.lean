namespace VariableLengthQuantity

private def encodeNatOrig (n : Nat) : Array UInt8 :=
  if n == 0 then #[0]
  else
    -- Collect 7-bit chunks LSB-first into a temporary array.
    let chunks : Array UInt8 := Id.run do
      let mut arr : Array UInt8 := #[]
      let mut v := n
      while v > 0 do
        arr := arr.push (UInt8.ofNat (v &&& 0x7F))
        v := v >>> 7
      return arr
    -- Reverse to MSB-first via Array.ofFn (second allocation).
    let sz := chunks.size
    Array.ofFn (fun (i : Fin sz) =>
      let byte := chunks[sz - 1 - i.val]!
      if i.val < sz - 1 then byte ||| 0x80 else byte)

def encodeOrig (integers : Array Nat) : ByteArray :=
  ByteArray.mk (integers.foldl (fun acc n => acc ++ encodeNatOrig n) #[])

def decodeOrig (bytes : ByteArray) : Option (Array Nat) :=
  let n := bytes.size
  let (out, valid) : Array Nat × Bool := Id.run do
    let mut out   : Array Nat := #[]
    let mut i     : Nat       := 0
    let mut valid : Bool      := true
    while i < n && valid do
      let mut value : Nat  := 0
      let mut more  : Bool := true
      while more do
        if i >= n then
          valid := false
          more  := false
        else
          let byte := bytes[i]!
          i     := i + 1
          value := (value <<< 7) ||| (byte &&& 0x7F).toNat
          if byte &&& 0x80 == 0 then
            more := false
      if valid then
        out := out.push value
    return (out, valid)
  if valid then some out else none

private def groupCount (n : Nat) : Nat :=
  Id.run do
    let mut cnt := 0
    let mut v   := n
    while v > 0 do
      cnt := cnt + 1
      v   := v >>> 7
    return cnt

/-- Append the VLQ encoding of n directly into buf; no intermediate arrays. -/
private def encodeNatFast (n : Nat) (buf : ByteArray) : ByteArray :=
  if n == 0 then buf.push 0
  else
    let k := groupCount n
    Id.run do
      let mut out := buf
      for i in [0:k] do
        let shift := (k - 1 - i) * 7
        let byte  := UInt8.ofNat ((n >>> shift) &&& 0x7F)
        out := out.push (if i < k - 1 then byte ||| 0x80 else byte)
      return out

def encodeFast (integers : Array Nat) : ByteArray :=
  integers.foldl (fun buf n => encodeNatFast n buf) ByteArray.empty

def decodeFast (bytes : ByteArray) : Option (Array Nat) :=
  let sz := bytes.size
  let (out, valid) : Array Nat × Bool := Id.run do
    let mut out   : Array Nat := #[]
    let mut i     : Nat       := 0
    let mut valid : Bool      := true
    while i < sz && valid do
      let mut value : Nat  := 0
      let mut cont  : Bool := true
      while cont do
        if i >= sz then
          valid := false
          cont  := false
        else
          let b : Nat := (bytes[i]!).toNat  -- read once as Nat
          i     := i + 1
          value := (value <<< 7) ||| (b &&& 0x7F)
          cont  := b &&& 0x80 != 0           -- no UInt8 comparison
      if valid then
        out := out.push value
    return (out, valid)
  if valid then some out else none

def encode := encodeFast
def decode := decodeFast

end VariableLengthQuantity