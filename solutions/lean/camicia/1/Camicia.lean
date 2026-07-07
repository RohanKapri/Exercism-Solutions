import Std

namespace Camicia

inductive Card where
  | C2 | C3 | C4 | C5 | C6 | C7 | C8 | C9
  | C10 | CJ | CQ | CK | CA
  deriving BEq, Repr

inductive Status where
  | finished | loop
  deriving BEq, Repr, Inhabited

structure Result where
  status : Status
  cards  : Nat
  tricks : Nat
  deriving BEq, Repr, Inhabited

def isPaymentCard : Card → Option Nat
  | .CJ => some 1
  | .CQ => some 2
  | .CK => some 3
  | .CA => some 4
  | _ => none

def normalizedCard : Card → UInt8
  | .CJ => 1
  | .CQ => 2
  | .CK => 3
  | .CA => 4
  | _ => 0

def normalizeDeck (deck : List Card) : List UInt8 :=
  deck.map normalizedCard

structure LoopKey where
  deckA : List UInt8
  deckB : List UInt8
  deriving BEq, Hashable

def collectPile (deck pileRev : List α) : List α :=
  deck ++ pileRev.reverse

def updateDeck (isA : Bool) (deckA deckB newDeck : List α) : List α × List α :=
  if isA then (newDeck, deckB) else (deckA, newDeck)

def otherPlayer (isA : Bool) : Bool :=
  not isA

partial def run
    (deckA deckB : List Card)
    (deckANorm deckBNorm : List UInt8)
    (pileRev : List Card)
    (pileNormRev : List UInt8)
    (turnIsA : Bool)
    (penalty : Option (Nat × Bool))
    (cardsPlayed tricks : Nat)
    (seen : Std.HashSet LoopKey) : Result :=
  let atRoundStart := pileRev.isEmpty && penalty.isNone
  if atRoundStart && (deckA.isEmpty || deckB.isEmpty) then
    { status := .finished, cards := cardsPlayed, tricks := tricks }
  else
    let step (seenNow : Std.HashSet LoopKey) : Result :=
      let (currentDeck, currentNorm, otherDeck, otherNorm) :=
        if turnIsA then
          (deckA, deckANorm, deckB, deckBNorm)
        else
          (deckB, deckBNorm, deckA, deckANorm)

      match currentDeck, currentNorm with
      | [], _
      | _, [] =>
          let winnerIsA := otherPlayer turnIsA
          let winnerDeck := collectPile otherDeck pileRev
          let winnerNorm := collectPile otherNorm pileNormRev
          let (newA, newB) := updateDeck winnerIsA deckA deckB winnerDeck
          let (newANorm, newBNorm) := updateDeck winnerIsA deckANorm deckBNorm winnerNorm
          if newA.isEmpty || newB.isEmpty then
            { status := .finished, cards := cardsPlayed, tricks := tricks + 1 }
          else
            run newA newB newANorm newBNorm [] [] winnerIsA none cardsPlayed (tricks + 1) seenNow
      | card :: rest, cardNorm :: restNorm =>
          let newPile := card :: pileRev
          let newPileNorm := cardNorm :: pileNormRev
          let cardsPlayed' := cardsPlayed + 1

          let (deckAAfterPlay, deckBAfterPlay, deckANormAfterPlay, deckBNormAfterPlay) :=
            if turnIsA then
              (rest, deckB, restNorm, deckBNorm)
            else
              (deckA, rest, deckANorm, restNorm)

          match penalty with
          | none =>
              match isPaymentCard card with
              | some due =>
                  run deckAAfterPlay deckBAfterPlay deckANormAfterPlay deckBNormAfterPlay newPile newPileNorm (otherPlayer turnIsA) (some (due, turnIsA)) cardsPlayed' tricks seenNow
              | none =>
                  run deckAAfterPlay deckBAfterPlay deckANormAfterPlay deckBNormAfterPlay newPile newPileNorm (otherPlayer turnIsA) none cardsPlayed' tricks seenNow
          | some (due, ownerIsA) =>
              match isPaymentCard card with
              | some newDue =>
                  run deckAAfterPlay deckBAfterPlay deckANormAfterPlay deckBNormAfterPlay newPile newPileNorm (otherPlayer turnIsA) (some (newDue, turnIsA)) cardsPlayed' tricks seenNow
              | none =>
                  if due = 1 then
                    let winnerDeck :=
                      if ownerIsA then
                        collectPile deckAAfterPlay newPile
                      else
                        collectPile deckBAfterPlay newPile
                    let winnerNorm :=
                      if ownerIsA then
                        collectPile deckANormAfterPlay newPileNorm
                      else
                        collectPile deckBNormAfterPlay newPileNorm

                    let (newA, newB) := updateDeck ownerIsA deckAAfterPlay deckBAfterPlay winnerDeck
                    let (newANorm, newBNorm) := updateDeck ownerIsA deckANormAfterPlay deckBNormAfterPlay winnerNorm

                    if newA.isEmpty || newB.isEmpty then
                      { status := .finished, cards := cardsPlayed', tricks := tricks + 1 }
                    else
                      run newA newB newANorm newBNorm [] [] ownerIsA none cardsPlayed' (tricks + 1) seenNow
                  else
                    run deckAAfterPlay deckBAfterPlay deckANormAfterPlay deckBNormAfterPlay newPile newPileNorm turnIsA (some (due - 1, ownerIsA)) cardsPlayed' tricks seenNow

    if atRoundStart then
      let key : LoopKey := { deckA := deckANorm, deckB := deckBNorm }
      if seen.contains key then
        { status := .loop, cards := cardsPlayed, tricks := tricks }
      else
        step (seen.insert key)
    else
      step seen

def simulateGame (playerA playerB : List Card) : Result :=
  run
    playerA
    playerB
    (normalizeDeck playerA)
    (normalizeDeck playerB)
    []
    []
    true
    none
    0
    0
    ({} : Std.HashSet LoopKey)

end Camicia