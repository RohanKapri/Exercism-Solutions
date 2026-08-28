namespace Anagram

private def charMap : String → Array Nat :=
  String.foldl (init := Array.replicate 26 0)
    fun m c => 
      let idx := c.toNat - 'a'.toNat
      m.modify idx (· + 1)
    
def findAnagrams (subject : String) (candidates : List String) : List String :=
  let subLower := subject.toLower
  let subMap := charMap subLower
  candidates.filter fun cs =>
    let csLower := cs.toLower
    csLower ≠ subLower && charMap csLower == subMap

end Anagram