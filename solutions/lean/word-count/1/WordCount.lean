import Std.Data.HashMap

namespace WordCount

def countWords (sentence : String) : Std.HashMap String Nat :=
  let addWord (counts : Std.HashMap String Nat) (charsRev : List Char) : Std.HashMap String Nat :=
    if charsRev.isEmpty then
      counts
    else
      let word := String.ofList charsRev.reverse
      counts.alter word (fun
        | some n => some (n + 1)
        | none => some 1)

  let rec go (remaining : List Char) (currentRev : List Char) (counts : Std.HashMap String Nat) : Std.HashMap String Nat :=
    match remaining with
    | [] => addWord counts currentRev
    | ch :: rest =>
      if ch.isAlphanum then
        go rest (ch.toLower :: currentRev) counts
      else if ch = '\'' then
        match rest with
        | next :: _ =>
          if !currentRev.isEmpty && next.isAlphanum then
            go rest (ch :: currentRev) counts
          else
            go rest [] (addWord counts currentRev)
        | [] =>
          addWord counts currentRev
      else
        go rest [] (addWord counts currentRev)

  go sentence.toList [] {}

end WordCount