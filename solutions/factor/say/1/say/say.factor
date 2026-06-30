USING: arrays combinators kernel locals math math.parser sequences strings typed ;
IN: say

CONSTANT: names { f "one" "two" "three" "four" "five" "six" "seven" "eight" "nine" "ten" "eleven" "twelve" "thirteen" "fourteen" "fifteen" "sixteen" "seventeen" "eighteen" "nineteen" }

CONSTANT: decades { f f "twenty" "thirty" "forty" "fifty" "sixty" "seventy" "eighty" "ninety" }

:: say-triplet ( n dest -- )
    {
        { [ n 0 = ] [ ] }
        { [ n 20 < ] [ n names nth dest push ] }
        { [ n 100 >= ] [ n 100 /mod swap dest say-triplet "hundred" dest push dest say-triplet ] }
        [
            n 10 /mod swap decades nth swap
            dup 0 =
            [
                drop
            ]
            [
                names nth 2array "-" join
            ]
            if
            dest push
        ]
    }
    cond ;

:: say-triplet-place ( n place dest -- )
    n 0 >
    [
        n dest say-triplet
        place dest push
    ]
    when ;

TYPED:: say ( n: integer -- str: string )
    n [ 0 < ] [ 999999999999 > ] bi or [ "input out of range" throw ] when
    n 0 =
    [
        "zero"
    ]
    [
        V{ } clone :> result

        n
        1000000000 /mod swap "billion" result say-triplet-place
        1000000 /mod swap "million" result say-triplet-place
        1000 /mod swap "thousand" result say-triplet-place
        result say-triplet

        result " " join
    ]
    if ;