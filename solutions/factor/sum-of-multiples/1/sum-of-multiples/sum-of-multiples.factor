USING: kernel math math.functions sequences ;
IN: sum-of-multiples
: contains-multiple? ( factors n -- ? )
    swap [ divisor? ] with any? ;
: sum-of-multiples-loop ( acc factors n -- sum )
    dup 0 <=
    [
        2drop ! acc
    ]
    [
        2dup contains-multiple?
        [
            rot dupd + ! factors n acc
            -rot
        ]
        [
            ! acc factors n
        ]
        if

        1 -
        sum-of-multiples-loop
    ]
    if ;

: sum-of-multiples ( factors limit -- sum )
    1 - swap
    [ 0 > ] filter ! limit factors
    0 spin sum-of-multiples-loop ;