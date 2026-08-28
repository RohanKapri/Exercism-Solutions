USING: arrays kernel locals math sequences ;
IN: sieve

:: primes ( limit -- primes )
    limit 1 +  f <array> :> table
    V{ } clone :> result
    2 :> p!
    0 :> m!

    [ p limit <= ]
    [
        p table nth
        [
            p result push

            p p * m!
            [ m limit <= ]
            [
                t m table set-nth
                m p + m!
            ]
            while
        ]
        unless


        p 1 + p!
    ]
    while

    result ;