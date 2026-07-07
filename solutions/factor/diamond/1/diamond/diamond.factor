USING: kernel locals math ranges sequences strings ;
IN: diamond

:: rows ( letter -- rows )
    letter CHAR: A - :> n

    n neg  n
    [a..b]
    [| i |
        n neg  n
        [a..b]
        [| j |
            i abs j abs + n =
            [
                n i abs - CHAR: A +
            ]
            [
                32
            ]
            if
        ]
        map >string
    ]
    map ;