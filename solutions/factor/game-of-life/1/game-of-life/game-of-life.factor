USING: arrays kernel locals math math.order ranges sequences ;
IN: game-of-life

:: cell ( i j matrix -- bit )
    i matrix nth j neg shift 1 bitand ;

:: tick ( matrix cols -- matrix' )
    matrix length :> rows
    rows 0 <array> :> result

    rows <iota>
    [| i |
        cols <iota>
        [| j |
            i j matrix cell :> previous
            previous neg :> neighbors!

            0 i 1 - max
            i 2 + rows min
            [a..b)
            [| ni |
                0 j 1 - max
                j 2 + cols min
                [a..b)
                [| nj |
                    ni nj matrix cell neighbors + neighbors!
                ]
                each
            ]
            each

            previous neighbors bitor 3 =
            [
                1 j shift  i result nth  bitor  i result set-nth
            ]
            when
        ]
        each
    ]
    each

    result ;