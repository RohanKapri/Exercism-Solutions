namespace House

abbrev VerseIndex := { x : Nat // 1 ≤ x ∧ x ≤ 12 }

private def phrases : Array String := #[
  "the house that Jack built",
  "the malt that lay in",
  "the rat that ate",
  "the cat that killed",
  "the dog that worried",
  "the cow with the crumpled horn that tossed",
  "the maiden all forlorn that milked",
  "the man all tattered and torn that kissed",
  "the priest all shaven and shorn that married",
  "the rooster that crowed in the morn that woke",
  "the farmer sowing his corn that kept",
  "the horse and the hound and the horn that belonged to"
]

def recite (startVerse endVerse : VerseIndex) : String := Id.run do
  let s := startVerse.val
  let e := endVerse.val
  -- Build tail(s): anchor at phrases[0]+"." then prepend phrases[1..s-1] in order.
  let mut tail := phrases[0]! ++ "."
  for i in [:s - 1] do
    tail := phrases[i + 1]! ++ " " ++ tail
  -- Collect verses; each step prepends one more phrase to grow the tail.
  let mut verses : Array String := Array.mkEmpty (e - s + 1)
  for i in [:e - s + 1] do
    if i > 0 then
      tail := phrases[s - 1 + i]! ++ " " ++ tail
    verses := verses.push ("This is " ++ tail)
  return String.intercalate "\n\n" verses.toList

end House
                             