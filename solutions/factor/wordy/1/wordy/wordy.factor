USING: combinators kernel locals math math.parser sequences splitting ;
IN: wordy

ERROR: invalid-question ;

SYMBOLS: plus minus multiplied-by divided-by ;

:: answer-loop ( words -- result )
    plus :> operator!
    0 :> left!
    f :> by!

    words
    [| word |
        operator
        [
            word "by" =
            [
                by [ invalid-question ] when
                t by!
            ]
            [
                word string>number :> right!
                right [ invalid-question ] unless

                operator
                {
                    { plus [ f ] }
                    { minus [ f ] }
                    { multiplied-by [ t ] }
                    { divided-by [ t ] }
                    [ invalid-question ]
                }
                case
                by = [ invalid-question ] unless

                left right
                operator
                {
                    { plus [ + ] }
                    { minus [ - ] }
                    { multiplied-by [ * ] }
                    { divided-by [ / ] }
                    [ invalid-question ]
                }
                case
                left!

                f operator!
                f by!
            ]
            if
        ]
        [
            word
            {
                { "plus" [ plus ] }
                { "minus" [ minus ] }
                { "multiplied" [ multiplied-by ] }
                { "divided" [ divided-by ] }
                [ invalid-question ]
            }
            case
            operator!
        ]
        if
    ]
    each

    operator [ invalid-question ] when

    left ;

: answer ( question -- result )
    "?" ?tail-slice
    [ invalid-question ] unless

    "What is " ?head-slice
    [ invalid-question ] unless

    " " split harvest answer-loop ;