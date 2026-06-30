namespace Yacht

inductive Category where
  | ones | twos | threes | fours | fives | sixes
  | choice | fourOfAKind | fullHouse | yacht
  | littleStraight | bigStraight
  deriving BEq, Repr

abbrev Die   := { x : Nat // 1 ≤ x ∧ x ≤ 6 }
abbrev Throw := Vector Die 5

def score (dice : Throw) (category: Category) : Nat :=
  -- One pass: build frequency table counts[0..6] and accumulate the total.
  -- counts[n] = number of dice showing face n (index 0 is unused; 1–6 are used).
  let (counts, total) :=
    dice.toArray.foldl (fun (c, s) d => (c.set! d.val (c[d.val]! + 1), s + d.val))
                       (Array.replicate 7 0, 0)
  match category with
  | .ones           => counts[1]!
  | .twos           => counts[2]! * 2
  | .threes         => counts[3]! * 3
  | .fours          => counts[4]! * 4
  | .fives          => counts[5]! * 5
  | .sixes          => counts[6]! * 6
  | .choice         => total
  | .yacht          =>
    -- All five dice show the same face iff some face has count 5.
    if counts.any (· == 5) then 50 else 0
  | .fourOfAKind    =>
    if      counts[1]! ≥ 4 then 4
    else if counts[2]! ≥ 4 then 8
    else if counts[3]! ≥ 4 then 12
    else if counts[4]! ≥ 4 then 16
    else if counts[5]! ≥ 4 then 20
    else if counts[6]! ≥ 4 then 24
    else 0
  | .fullHouse      =>
    let hasThree := counts[1]! == 3 || counts[2]! == 3 || counts[3]! == 3 ||
                    counts[4]! == 3 || counts[5]! == 3 || counts[6]! == 3
    let hasTwo   := counts[1]! == 2 || counts[2]! == 2 || counts[3]! == 2 ||
                    counts[4]! == 2 || counts[5]! == 2 || counts[6]! == 2
    if hasThree && hasTwo then total else 0
  | .littleStraight =>
    if counts[1]! ≥ 1 && counts[2]! ≥ 1 && counts[3]! ≥ 1 &&
       counts[4]! ≥ 1 && counts[5]! ≥ 1 then 30 else 0
  | .bigStraight    =>
    if counts[2]! ≥ 1 && counts[3]! ≥ 1 && counts[4]! ≥ 1 &&
       counts[5]! ≥ 1 && counts[6]! ≥ 1 then 30 else 0

end Yacht