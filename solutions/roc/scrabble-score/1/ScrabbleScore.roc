# ScrabbleScore.roc
module [score]

score : Str -> U64
score =
    |word|
        word
            |> Str.with_ascii_uppercased
            |> Str.walk_utf8(0, |acc, byte| acc + letterPoints(byte))


letterPoints : U8 -> U64
letterPoints =
    |b|
        when b is
            # 1 point
            'A' | 'E' | 'I' | 'O' | 'U' | 'L' | 'N' | 'R' | 'S' | 'T' -> 1
            # 2 points
            'D' | 'G' -> 2
            # 3 points
            'B' | 'C' | 'M' | 'P' -> 3
            # 4 points
            'F' | 'H' | 'V' | 'W' | 'Y' -> 4
            # 5 points
            'K' -> 5
            # 8 points
            'J' | 'X' -> 8
            # 10 points
            'Q' | 'Z' -> 10
            # anything else (non-letters) contributes 0
            _ -> 0
    