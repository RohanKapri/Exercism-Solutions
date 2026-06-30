USING: arrays kernel locals math sequences ;
IN: saddle-points

:: saddle-points ( matrix -- points )
    matrix empty?
    [
        { }
    ]
    [
        0 matrix nth empty?
        [
            { }
        ]
        [
            matrix [ maximum ] map :> largest
            matrix flip [ minimum ] map :> smallest
            V{ } clone :> result

            matrix length <iota>
            [| row |
                0 matrix nth length <iota>
                [| column |
                    column row matrix nth nth :> element
                    row largest nth element =
                    [
                        column smallest nth element =
                        [
                            row 1 + column 1 + 2array result push
                        ]
                        when
                    ]
                    when
                ]
                each
            ]
            each

            result >array
        ]
        if
    ]
    if ;