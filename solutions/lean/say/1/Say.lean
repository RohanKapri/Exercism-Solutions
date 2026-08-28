namespace Say

private def onesAndTeens : Array String :=
  #[
    "zero", "one", "two", "three", "four", "five", "six", "seven", "eight", "nine",
    "ten", "eleven", "twelve", "thirteen", "fourteen", "fifteen", "sixteen", "seventeen", "eighteen", "nineteen"
  ]

private def tensTable : Array String :=
  #["", "", "twenty", "thirty", "forty", "fifty", "sixty", "seventy", "eighty", "ninety"]

private def spellUnder100 (n : Nat) : String :=
  if n < 20 then
    onesAndTeens[n]!
  else
    let tens := n / 10;
    let ones := n % 10;
    let base := tensTable[tens]!;
    if ones = 0 then
      base
    else
      base ++ "-" ++ onesAndTeens[ones]!

private def spellUnder1000 (n : Nat) : String :=
  let hundreds := n / 100;
  let rest := n % 100;
  if hundreds = 0 then
    spellUnder100 rest
  else
    if rest = 0 then
      onesAndTeens[hundreds]! ++ " hundred"
    else
      onesAndTeens[hundreds]! ++ " hundred " ++ spellUnder100 rest

private def under1000Table : Array String :=
  Id.run do
    let mut out : Array String := #[]
    for i in [0:1000] do
      out := out.push (spellUnder1000 i)
    return out

private def sayUnder1000Fast (n : Nat) : String :=
  under1000Table[n]!

private def appendPart (acc part : String) : String :=
  if part.isEmpty then
    acc
  else if acc.isEmpty then
    part
  else
    acc ++ " " ++ part

private def scaledPart (value : Nat) (scale : String) : String :=
  if value = 0 then
    ""
  else
    sayUnder1000Fast value ++ " " ++ scale

private def onesPart (value : Nat) : String :=
  if value = 0 then "" else sayUnder1000Fast value

def say (number : Fin 1000000000000) : String :=
  let n := number.val;
  if n = 0 then
    "zero"
  else
    let billions := n / 1000000000;
    let millions := (n / 1000000) % 1000;
    let thousands := (n / 1000) % 1000;
    let ones := n % 1000;
    let out := appendPart "" (scaledPart billions "billion");
    let out := appendPart out (scaledPart millions "million");
    let out := appendPart out (scaledPart thousands "thousand");
    appendPart out (onesPart ones)

end Say
                                                   