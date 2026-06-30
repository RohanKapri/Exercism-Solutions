USING: arrays combinators kernel locals math sequences ;
IN: spiral-matrix

:: spiral-matrix ( n -- matrix )
    n [ n  n n *  <array> ] replicate :> result
    0 :> value!
    0 :> row!
    0 :> column!
    n 1 - :> length!

    [ length 0 > ]
    [
        length
        [
            value 1 + dup value!
            column dup 1 + column!
            row result nth
            set-nth
        ]
        times

        length
        [
            value 1 + dup value!
            column
            row dup 1 + row! result nth
            set-nth
        ]
        times

        length
        [
            value 1 + dup value!
            column dup 1 - column!
            row result nth
            set-nth
        ]
        times

        length
        [
            value 1 + dup value!
            column
            row dup 1 - row! result nth
            set-nth
        ]
        times

        row 1 + row!
        column 1 + column!
        length 2 - length!
    ]
    while

    result ;