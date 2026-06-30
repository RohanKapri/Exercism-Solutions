USING: arrays kernel locals math math.functions sequences vectors ;
IN: pythagorean-triplet

:: triplets-search ( vec n a -- triplets )
    n 2 a * - n * ! n * (n - 2 * a)
    n a - 2 * ! 2 * (n - a)
    [ divisor? ] [ /i ] 2bi ! divisor? b
    dup a <
    [
        2drop vec
    ]
    [
        swap
        [
            a swap ! a b
            2dup + n - neg ! c
            3array vec push
        ]
        [
            drop
        ]
        if

        vec n  a 1 +  triplets-search
    ]
    if ;

:: triplets-with-sum ( n -- triplets )
    n 2 <
    [
        { }
    ]
    [
        V{ } clone  n 1 triplets-search >array
    ]
    if ;