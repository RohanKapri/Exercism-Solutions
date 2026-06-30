import Std.Data.TreeMap

namespace ParallelLetterFrequency

private def alphabetSize : Nat := 26

private def emptyCounts : Array Nat :=
  Array.replicate alphabetSize 0

private def byteToLowerIndex? (b : UInt8) : Option Nat :=
  let n := b.toNat
  if 65 <= n && n <= 90 then
    some (n - 65)
  else if 97 <= n && n <= 122 then
    some (n - 97)
  else
    none

private def countText (text : String) : Array Nat :=
  Id.run do
    let bytes := text.toUTF8.data
    let mut counts := emptyCounts
    let mut i := 0
    while i < bytes.size do
      match byteToLowerIndex? bytes[i]! with
      | some idx =>
          counts := counts.set! idx (counts[idx]! + 1)
      | none =>
          pure ()
      i := i + 1
    counts

private def mergeCounts (left right : Array Nat) : Array Nat :=
  Id.run do
    let mut out := left
    let mut i := 0
    while i < alphabetSize do
      out := out.set! i (out[i]! + right[i]!)
      i := i + 1
    out

private def countsToTreeMap (counts : Array Nat) : Std.TreeMap Char Nat :=
  Id.run do
    let mut out : Std.TreeMap Char Nat := {}
    let a := 'a'.toNat
    let mut i := 0
    while i < alphabetSize do
      let n := counts[i]!
      if n != 0 then
        out := out.insert (Char.ofNat (a + i)) n
      i := i + 1
    out

def calculateFrequencies (texts : List String) : IO (Std.TreeMap Char Nat) :=
  let tasks := texts.map (fun text => Task.spawn (fun _ => countText text))
  let perText := tasks.map Task.get
  pure (countsToTreeMap (perText.foldl mergeCounts emptyCounts))

end ParallelLetterFrequency
                                  