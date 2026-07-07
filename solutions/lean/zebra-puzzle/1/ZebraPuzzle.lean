namespace ZebraPuzzle

inductive Nationality where
  | Englishman
  | Japanese
  | Norwegian
  | Spaniard
  | Ukrainian
  deriving BEq, Inhabited, Repr

inductive Color where
  | red | green | ivory | yellow | blue
  deriving BEq, Inhabited, Repr

inductive Pet where
  | dog | snail | fox | horse | zebra
  deriving BEq, Inhabited, Repr

inductive Drink where
  | coffee | tea | milk | orangeJuice | water
  deriving BEq, Inhabited, Repr

inductive Hobby where
  | dancing | painting | reading | football | chess
  deriving BEq, Inhabited, Repr

private def natIdx : Nationality → Nat
  | .Englishman => 0 | .Japanese => 1 | .Norwegian => 2 | .Spaniard => 3 | .Ukrainian => 4

private def natOf (i : Nat) : Nationality :=
  match i with | 0 => .Englishman | 1 => .Japanese | 2 => .Norwegian | 3 => .Spaniard | _ => .Ukrainian

private def colorIdx : Color → Nat
  | .red => 0 | .green => 1 | .ivory => 2 | .yellow => 3 | .blue => 4

private def petIdx : Pet → Nat
  | .dog => 0 | .snail => 1 | .fox => 2 | .horse => 3 | .zebra => 4

private def drinkIdx : Drink → Nat
  | .coffee => 0 | .tea => 1 | .milk => 2 | .orangeJuice => 3 | .water => 4

private def hobbyIdx : Hobby → Nat
  | .dancing => 0 | .painting => 1 | .reading => 2 | .football => 3 | .chess => 4

private def houseVal (houses : List Nat) (i : Nat) : Nat := houses[i]!

private def idxOf (houses : List Nat) (v : Nat) : Nat :=
  match houses.findIdx? (· == v) with | some i => i | none => 0

private def sameHouse (a b : List Nat) (v1 v2 : Nat) : Bool :=
  idxOf a v1 == idxOf b v2

private def adjacentValues (a b : List Nat) (v1 v2 : Nat) : Bool :=
  let i := idxOf a v1
  let j := idxOf b v2
  i + 1 == j || j + 1 == i

private def usedAt? (used : Nat) (v : Nat) : Bool := (used >>> v) &&& 1 == 1

private def markUsed (used : Nat) (v : Nat) : Nat := used ||| (1 <<< v)

private def mergeFixed (f g : Nat → Option Nat) : Nat → Option Nat := fun i =>
  match f i with | some v => some v | none => g i

private def satisfies (nat colors pets drinks hobbies : List Nat) : Bool :=
  houseVal nat 0 == natIdx .Norwegian &&
  houseVal drinks 2 == drinkIdx .milk &&
  houseVal colors 1 == colorIdx .blue &&
  sameHouse nat colors (natIdx .Englishman) (colorIdx .red) &&
  sameHouse nat pets (natIdx .Spaniard) (petIdx .dog) &&
  sameHouse colors drinks (colorIdx .green) (drinkIdx .coffee) &&
  sameHouse nat drinks (natIdx .Ukrainian) (drinkIdx .tea) &&
  sameHouse pets hobbies (petIdx .snail) (hobbyIdx .dancing) &&
  sameHouse colors hobbies (colorIdx .yellow) (hobbyIdx .painting) &&
  adjacentValues hobbies pets (hobbyIdx .reading) (petIdx .fox) &&
  adjacentValues hobbies pets (hobbyIdx .painting) (petIdx .horse) &&
  sameHouse hobbies drinks (hobbyIdx .football) (drinkIdx .orangeJuice) &&
  sameHouse nat hobbies (natIdx .Japanese) (hobbyIdx .chess)

/-- Backtracking permutation search; `cont` runs only on assignments passing `check`. -/
private partial def searchPerm
    (pos used : Nat) (acc : List Nat) (fixed : Nat → Option Nat)
    (check : List Nat → Bool) (cont : List Nat → Option (List Nat × List Nat × List Nat × List Nat × List Nat)) :
    Option (List Nat × List Nat × List Nat × List Nat × List Nat) :=
  if pos == 5 then
    let arr := acc |> List.reverse
    if !check arr then none else cont arr
  else
    let candidates :=
      match fixed pos with
      | some v => [v]
      | none => [0, 1, 2, 3, 4]
    candidates.findSome? fun v =>
      if usedAt? used v then none
      else searchPerm (pos + 1) (markUsed used v) (v :: acc) fixed check cont

private def fixedNorwegian : Nat → Option Nat := fun i =>
  if i == 0 then some (natIdx .Norwegian) else none

private def fixedMilk : Nat → Option Nat := fun i =>
  if i == 2 then some (drinkIdx .milk) else none

private def fixedBlue : Nat → Option Nat := fun i =>
  if i == 1 then some (colorIdx .blue) else none

private def fixedIvoryGreen (ivory green : Nat) : Nat → Option Nat := fun i =>
  if i == ivory then some (colorIdx .ivory)
  else if i == green then some (colorIdx .green)
  else none

private def natDrinkOk (nat drinks : List Nat) : Bool :=
  sameHouse nat drinks (natIdx .Ukrainian) (drinkIdx .tea)

private def natColorDrinkOk (nat colors drinks : List Nat) : Bool :=
  sameHouse nat colors (natIdx .Englishman) (colorIdx .red) &&
  sameHouse colors drinks (colorIdx .green) (drinkIdx .coffee)

private def petsOk (nat pets : List Nat) : Bool :=
  sameHouse nat pets (natIdx .Spaniard) (petIdx .dog)

/-- With house 1 blue, green is only possible immediately right of ivory at (3, 4). -/
private def ivoryGreenPairs : List (Nat × Nat) := [(3, 4)]

private partial def solveColors
    (nat drinks : List Nat) (ivory green : Nat) : Option (List Nat × List Nat × List Nat × List Nat × List Nat) :=
  let colorFixed := mergeFixed fixedBlue (fixedIvoryGreen ivory green)
  searchPerm 0 0 ([] : List Nat) colorFixed
    (fun colors => natColorDrinkOk nat colors drinks)
    fun colors =>
      searchPerm 0 0 ([] : List Nat) (fun _ => none) (fun pets => petsOk nat pets) fun pets =>
        searchPerm 0 0 ([] : List Nat) (fun _ => none)
          (fun hobbies => satisfies nat colors pets drinks hobbies)
          fun hobbies => some (nat, colors, pets, drinks, hobbies)

private partial def solve : Option (List Nat × List Nat × List Nat × List Nat × List Nat) :=
  searchPerm 0 0 ([] : List Nat) fixedNorwegian (fun _ => true) fun nat =>
    searchPerm 0 0 ([] : List Nat) fixedMilk (fun drinks => natDrinkOk nat drinks) fun drinks =>
      ivoryGreenPairs.findSome? fun (ivory, green) =>
        solveColors nat drinks ivory green

private def solution : List Nat × List Nat × List Nat × List Nat × List Nat :=
  match solve with
  | some sol => sol
  | none => panic "Zebra puzzle has no solution"

def drinksWater : Nationality :=
  let (nat, _, _, drinks, _) := solution
  natOf (houseVal nat (idxOf drinks (drinkIdx .water)))

def ownsZebra : Nationality :=
  let (nat, _, pets, _, _) := solution
  natOf (houseVal nat (idxOf pets (petIdx .zebra)))

end ZebraPuzzle