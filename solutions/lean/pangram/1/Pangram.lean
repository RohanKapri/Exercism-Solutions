namespace Pangram

private def all := (1 <<< 26) - 1

def isPangram (sentence : String) : Bool := Id.run do
  let mut bmp := 0
  for c in sentence.toSlice.chars do
    if !c.isAlpha then continue
    let idx := (c.toNat ||| 32) - 97
    bmp := bmp ||| (1 <<< idx)
  return bmp = all
  
end Pangram