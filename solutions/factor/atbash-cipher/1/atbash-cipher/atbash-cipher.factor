USING: combinators grouping kernel math sequences strings unicode ;
IN: atbash-cipher

: clean ( phrase -- str )
    >lower
    [
        [ letter? ] [ digit? ] bi or
    ]
    filter ;

: process ( phrase -- str )
    [
        dup letter?
        [
            CHAR: a
            CHAR: z
            +
            swap
            -
        ]
        [
        ]
        if
    ]
    map ;

: encode ( phrase -- str )
    clean
    5 group
    [ process ] map
    " " join ;

: decode ( phrase -- str )
    clean
    process ;