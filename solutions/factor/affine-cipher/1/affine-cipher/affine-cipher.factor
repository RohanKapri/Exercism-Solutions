USING: grouping kernel locals math sequences unicode ;
IN: affine-cipher

CONSTANT: inverses { f 1 f 9 f 21 f 15 f 3 f 19 f f f 7 f 23 f 11 f 5 f 17 f 25 }

: clean ( phrase -- str )
    >lower
    [
        [ letter? ] [ digit? ] bi or
    ]
    filter ;

:: process ( phrase a b -- str )
    phrase
    [
        dup letter?
        [
            CHAR: a -
            a *
            b +
            26 mod
            CHAR: a +
        ]
        [
        ]
        if
    ]
    map ;

:: encode ( phrase a b -- cipher )
    a inverses nth :> inverse
    inverse [ "a and m must be coprime." throw ] unless

    phrase clean
    5 group
    [ a b process ] map
    " " join ;

:: decode ( phrase a b -- plain )
    a inverses nth :> inverse
    inverse [ "a and m must be coprime." throw ] unless

    phrase clean
    inverse  26 inverse - b *  process ;