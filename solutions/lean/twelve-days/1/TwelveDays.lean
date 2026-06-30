namespace TwelveDays

abbrev VerseIndex := { x : Nat // 1 ≤ x ∧ x ≤ 12 }

private def ordinals : Array String := #[
  "first", "second", "third", "fourth", "fifth", "sixth",
  "seventh", "eighth", "ninth", "tenth", "eleventh", "twelfth"
]

private def giftParts : Array String := #[
  "a Partridge in a Pear Tree.",
  "two Turtle Doves",
  "three French Hens",
  "four Calling Birds",
  "five Gold Rings",
  "six Geese-a-Laying",
  "seven Swans-a-Swimming",
  "eight Maids-a-Milking",
  "nine Ladies Dancing",
  "ten Lords-a-Leaping",
  "eleven Pipers Piping",
  "twelve Drummers Drumming"
]

private def versePrefixes : Array String :=
  ordinals.map fun ord =>
    "On the " ++ ord ++ " day of Christmas my true love gave to me: "

private def giftSuffixes : Array String := Id.run do
  let mut suf : Array String := Array.mkEmpty 12
  suf := suf.push giftParts[0]!
  suf := suf.push (giftParts[1]! ++ ", and " ++ giftParts[0]!)
  let mut i : Nat := 2
  while i < 12 do
    suf := suf.push (giftParts[i]! ++ ", " ++ suf[i - 1]!)
    i := i + 1
  return suf

private def reciteVerse (v : Nat) : String :=
  versePrefixes[v - 1]! ++ giftSuffixes[v - 1]!

def recite (startVerse endVerse : VerseIndex) : List String :=
  let start  := startVerse.1
  let finish := endVerse.1
  (List.range (finish + 1 - start)).map fun offset =>
    reciteVerse (start + offset)

end TwelveDays