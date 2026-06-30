include std/sequence.e

public function rotateEncode(sequence text, atom shiftKey)
  for i = 1 to shiftKey do
    text = mapping(text, "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ", "bcdefghijklmnopqrstuvwxyzaBCDEFGHIJKLMNOPQRSTUVWXYZA")
  end for
  return text
end function
