USING: combinators kernel locals math math.functions ;
IN: perfect-numbers

:: classify ( number -- str )
    number 1 < [ "Classification is only possible for positive integers." throw ] when

    number :> n!
    1 :> a!
    2 :> p!
    0 :> s!

    [ p p * n <= ]
    [
        n p divisor?
        [
            p 1 + s!
            n p / n!

            [ n p divisor? ]
            [
                p s * 1 + s!
                n p / n!
            ]
            while

            a s * a!
        ]
        when

        p 1 + p!
    ]
    while

    n 1 >
    [
        n 1 + a * a!
    ]
    when

    a number - a!

    {
        { [ a number < ] [ "deficient" ] }
        { [ a number > ] [ "abundant" ] }
        [ "perfect" ]
    }
    cond ;