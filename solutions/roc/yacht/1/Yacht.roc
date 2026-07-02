module [score]

Category : [Ones, Twos, Threes, Fours, Fives, Sixes, FullHouse, FourOfAKind, LittleStraight, BigStraight, Choice, Yacht]

score : List U8, Category -> U8
score = |dice, category|
    when category is
        Ones -> count_value(dice, 1) * 1
        Twos -> count_value(dice, 2) * 2
        Threes -> count_value(dice, 3) * 3
        Fours -> count_value(dice, 4) * 4
        Fives -> count_value(dice, 5) * 5
        Sixes -> count_value(dice, 6) * 6
        FullHouse -> score_full_house(dice)
        FourOfAKind -> score_four_of_a_kind(dice)
        LittleStraight -> if is_little_straight(dice) then 30 else 0
        BigStraight -> if is_big_straight(dice) then 30 else 0
        Choice -> List.sum(dice)
        Yacht -> if is_yacht(dice) then 50 else 0

count_value : List U8, U8 -> U8
count_value = |dice, value|
    dice
    |> List.keep_if(|d| d == value)
    |> List.len
    |> Num.to_u8

is_yacht : List U8 -> Bool
is_yacht = |dice|
    when dice is
        [a, b, c, d, e] -> a == b and b == c and c == d and d == e
        _ -> Bool.false

score_full_house : List U8 -> U8
score_full_house = |dice|
    sorted = List.sort_asc(dice)
    when sorted is
        [a, b, c, d, e] if a == b and b == c and c != d and d == e -> a * 3 + d * 2
        [a, b, c, d, e] if a == b and b != c and c == d and d == e -> a * 2 + c * 3
        _ -> 0

score_four_of_a_kind : List U8 -> U8
score_four_of_a_kind = |dice|
    sorted = List.sort_asc(dice)
    when sorted is
        # Four of a kind: first four are same or last four are same
        [a, b, c, d, _] if a == b and b == c and c == d -> a * 4
        [_, b, c, d, e] if b == c and c == d and d == e -> b * 4
        _ -> 0

is_little_straight : List U8 -> Bool
is_little_straight = |dice|
    sorted = List.sort_asc(dice)
    sorted == [1, 2, 3, 4, 5]

is_big_straight : List U8 -> Bool
is_big_straight = |dice|
    sorted = List.sort_asc(dice)
    sorted == [2, 3, 4, 5, 6]
                 