let char_score c =
  match Char.lowercase_ascii c with
  | 'a' | 'e' | 'i' | 'o' | 'u' | 'l' | 'n' | 'r' | 's' | 't' -> 1
  | 'd' | 'g' -> 2
  | 'b' | 'c' | 'm' | 'p' -> 3
  | 'f' | 'h' | 'v' | 'w' | 'y' -> 4
  | 'k' -> 5
  | 'j' | 'x' -> 8
  | 'q' | 'z' -> 10
  | _ -> 0 (* Handles non-alphabetic characters safely *)

let score word =
  let rec total idx acc =
    if idx < 0 then acc
    else total (idx - 1) (acc + char_score word.[idx])
  in
  total (String.length word - 1) 0