USING: arrays kernel locals math math.functions sequences ;
IN: prime-factors

:: factors ( n -- factors )
    V{ } clone :> result

    n :> a!
    2 :> p!

    [
        a 1 =
    ]
    [
        a p divisor?
        [
            p result push
            a p /i a!
        ]
        [
            p 1 + p!
        ]
        if
    ]
    until

    result >array ;