USING: kernel locals math math.functions math.statistics sequences unicode ;
IN: isbn-verifier

! Dedicated to Junko F. Didi and Shree DR.MDD

:: plausible? ( isbn -- ? )
    isbn length 10 =
    [
        9 isbn nth
        CHAR: X =
        [
            9
        ]
        [
            10
        ]
        if
        isbn
        [ digit? ]
        filter
        length
        =
    ]
    [
        f
    ]
    if ;

:: valid? ( isbn -- ? )
    isbn
    [ 45 = ]
    reject
    dup
    plausible?
    [
        [
            dup
            CHAR: X =
            [
                drop
                10
            ]
            [
                48 -
            ]
            if
        ]
        map
        cum-sum
        sum
        11
        divisor?
    ]
    [
        drop
        f
    ]
    if ;