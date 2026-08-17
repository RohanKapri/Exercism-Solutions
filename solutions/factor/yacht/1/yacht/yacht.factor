USING: combinators kernel locals math sequences sorting ;
IN: yacht

:: yacht-score ( dice -- score )
    dice first
    dice last
    =
    [
        50
    ]
    [
        0
    ]
    if ;

:: ones-score ( dice -- score )
    dice
    [
        1 =
    ]
    filter length 1 * ;

:: twos-score ( dice -- score )
    dice
    [
        2 =
    ]
    filter length 2 * ;

:: threes-score ( dice -- score )
    dice
    [
        3 =
    ]
    filter length 3 * ;

:: fours-score ( dice -- score )
    dice
    [
        4 =
    ]
    filter length 4 * ;

:: fives-score ( dice -- score )
    dice
    [
        5 =
    ]
    filter length 5 * ;

:: sixes-score ( dice -- score )
    dice
    [
        6 =
    ]
    filter length 6 * ;

:: full-house-score ( dice -- score )
    0 dice nth  2 dice nth  =
    3 dice nth  4 dice nth  =
    and
    0 dice nth  1 dice nth  =
    2 dice nth  4 dice nth  =
    and
    or
    0 dice nth  4 dice nth  = not
    and
    [
        dice sum
    ]
    [
        0
    ]
    if ;


:: four-of-a-kind-score ( dice -- score )
    0 dice nth  3 dice nth  =
    1 dice nth  4 dice nth  =
    or
    [
        2 dice nth  4 *
    ]
    [
        0
    ]
    if ;

:: little-straight-score ( dice -- score )
    { 1 2 3 4 5 } dice =
    [ 30 ]
    [ 0 ]
    if ;

:: big-straight-score ( dice -- score )
    { 2 3 4 5 6 } dice =
    [ 30 ]
    [ 0 ]
    if ;

:: choice-score ( dice -- score )
    dice sum ;

:: score ( dice category -- score )
    dice sort

    category
    {
        { "yacht" [ yacht-score ] }
        { "ones" [ ones-score ] }
        { "twos" [ twos-score ] }
        { "threes" [ threes-score ] }
        { "fours" [ fours-score ] }
        { "fives" [ fives-score ] }
        { "sixes" [ sixes-score ] }
        { "full house" [ full-house-score ] }
        { "four of a kind" [ four-of-a-kind-score ] }
        { "little straight" [ little-straight-score ] }
        { "big straight" [ big-straight-score ] }
        { "choice" [ choice-score ] }
        [ 2drop 0 ]
    }
    case ;