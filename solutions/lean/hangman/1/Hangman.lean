import Std

namespace Hangman

inductive State where
  | ongoing | win | lose
  deriving BEq, Repr

structure Result where
  state : State
  remainingFailures : Nat
  maskedWord : String
  deriving BEq, Repr

private def initialFailures : Nat := 9

private def remainingFailuresFor (failures : Nat) : Nat :=
  initialFailures - failures

private def maskedWordFor (wordChars : List Char) (guessed : Std.HashSet Char) : String :=
  String.ofList <| wordChars.map fun ch => if guessed.contains ch then ch else '_'

private def currentState (distinctLetters revealed failures : Nat) : State :=
  if revealed == distinctLetters then
    .win
  else if failures > initialFailures then
    .lose
  else
    .ongoing

private def buildWordSet (wordChars : List Char) : Std.HashSet Char × Nat :=
  wordChars.foldl
    (fun (acc : Std.HashSet Char × Nat) ch =>
      let (wordSet, distinctLetters) := acc
      if wordSet.contains ch then
        acc
      else
        (wordSet.insert ch, distinctLetters + 1))
    (({} : Std.HashSet Char), 0)

private structure Game where
  failures : Nat
  guessed : Std.HashSet Char
  revealed : Nat

private def applyGuess
    (wordSet : Std.HashSet Char)
    (distinctLetters : Nat)
    (game : Game)
    (nextGuess : Char) : Except String Game := do
  match currentState distinctLetters game.revealed game.failures with
  | .win =>
      .error "cannot guess after the game is won"
  | .lose =>
      .error "cannot guess after the game is lost"
  | .ongoing =>
      if game.guessed.contains nextGuess then
        return { game with failures := game.failures + 1 }
      let guessed := game.guessed.insert nextGuess
      if wordSet.contains nextGuess then
        return {
          failures := game.failures
          guessed := guessed
          revealed := game.revealed + 1
        }
      return {
        failures := game.failures + 1
        guessed := guessed
        revealed := game.revealed
      }

def guess (word : String) (guesses : List Char) : Except String Result := do
  let wordChars := word.toList
  let (wordSet, distinctLetters) := buildWordSet wordChars
  let finalGame ← guesses.foldlM (fun game nextGuess => applyGuess wordSet distinctLetters game nextGuess) {
    failures := 0
    guessed := {}
    revealed := 0
  }
  return {
    state := currentState distinctLetters finalGame.revealed finalGame.failures
    remainingFailures := remainingFailuresFor finalGame.failures
    maskedWord := maskedWordFor wordChars finalGame.guessed
  }

end Hangman
                          