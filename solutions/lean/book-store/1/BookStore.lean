import Std.Data.HashMap

namespace BookStore

def Book := { x : Nat // x ≥ 1 ∧ x ≤ 5 }

private abbrev Counts := List Nat
private abbrev Memo := Std.HashMap Nat Nat

private def encode (base : Nat) (counts : Counts) : Nat :=
  counts.foldl (fun acc n => acc * base + n) 0

private def groupPrice : Nat → Nat
  | 0 => 0
  | 1 => 800
  | 2 => 1520
  | 3 => 2160
  | 4 => 2560
  | _ => 3000

private def normalize (counts : Counts) : Counts :=
  counts.mergeSort fun a b => decide (a ≥ b)

private def bumpCounts (counts : Counts) (book : Nat) : Counts :=
  match counts with
  | [a, b, c, d, e] =>
      match book with
      | 1 => [a + 1, b, c, d, e]
      | 2 => [a, b + 1, c, d, e]
      | 3 => [a, b, c + 1, d, e]
      | 4 => [a, b, c, d + 1, e]
      | 5 => [a, b, c, d, e + 1]
      | _ => [a, b, c, d, e]
  | _ => counts

private def positiveCount : Counts → Nat
  | [] => 0
  | 0 :: rest => positiveCount rest
  | _ :: rest => positiveCount rest + 1

private def decrementFirst : Nat → Counts → Option Counts
  | 0, counts => some counts
  | _ + 1, [] => none
  | k + 1, x :: xs =>
      if x = 0 then
        none
      else
        match decrementFirst k xs with
        | none => none
        | some rest => some ((x - 1) :: rest)

private partial def bestFromCounts (base : Nat) : Counts → StateM Memo Nat
  | counts => do
      let counts := normalize counts
      match counts with
      | [] => pure 0
      | 0 :: _ => pure 0
      | _ => do
          let key := encode base counts
          let memo ← get
          if memo.contains key then
            pure (memo.getD key 0)
          else
            let total := counts.foldl (fun acc n => acc + n) 0
            let limit := positiveCount counts
            let rec loop (k : Nat) (best : Nat) : StateM Memo Nat := do
              if k ≤ limit then
                match decrementFirst k counts with
                | none => pure best
                | some nextCounts => do
                    let candidate := groupPrice k + (← bestFromCounts base nextCounts)
                    loop (k + 1) (min best candidate)
              else
                pure best
            let best ← loop 1 (total * 800)
            modify (fun memo => Std.HashMap.insert memo key best)
            pure best

def total (basket : List Book) : Nat :=
  let counts :=
    basket.foldl (init := ([0, 0, 0, 0, 0] : Counts)) fun counts book =>
      bumpCounts counts book.val
  let memo0 := Std.HashMap.emptyWithCapacity (basket.length + 1)
  let (price, _) := (bestFromCounts (basket.length + 1) counts).run memo0
  price

end BookStore