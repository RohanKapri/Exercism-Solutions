USING: arrays kernel locals math math.order sequences ;
IN: all-your-base

:: rebase ( digits input-base output-base -- digits' )
    input-base 2 < [ "input base must be >= 2" throw ] when
    output-base 2 < [ "output base must be >= 2" throw ] when
    digits
    [| digit |
        digit 0  input-base 1 -  between?
    ]
    all? [ "all digits must satisfy 0 <= d < input base" throw ] unless

    0 :> n!

    digits
    [| digit |
        input-base n * digit + n!
    ]
    each

    V{ } clone :> result

    [ n 0 = ]
    [
        n output-base /mod
        result push
        n!
    ]
    until

    result empty? [ 0 result push ] when

    result reverse >array ;