USING: arrays combinators kernel locals math math.order ranges sequences strings ;
IN: flower-field

CONSTANT: space 32
CONSTANT: flower 42

:: annotate ( garden -- annotated )
    V{ } clone :> result
    f :> result-line!
    f :> ar!
    f :> br!
    f :> ac!
    f :> bc!
    f :> count!

    garden
    [| garden-line row |
        row 1 - 0 max ar!
        row 2 + garden length min br!
        V{ } clone result-line!

        garden-line
        [| garden-ch column |
            column 1 - 0 max ac!
            column 2 + garden-line length min bc!

            0 count!
            ar br [a..b)
            [| r |
                ac bc [a..b)
                [| c |
                    c r garden nth nth flower = [ count 1 + count! ] when
                ]
                each
            ]
            each

            {
                { [ column row garden nth nth flower = ] [ flower ] }
                { [ count 0 = ] [ space ] }
                [ count CHAR: 0 + ]
            }
            cond

            result-line push
        ]
        each-index

        result-line >string result push
    ]
    each-index

    result >array ;