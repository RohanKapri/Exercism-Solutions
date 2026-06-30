USING: kernel locals math math.functions sequences ;
IN: luhn

:: score ( n i -- s )
    i 2 divisor?
    [
        n
    ]
    [
        n 2 *
        dup 9 > [ 9 - ] when
    ]
    if ;

:: valid-impl? ( value -- ? )
    0 :> total!

    value
    [
        [ 48 < ] [ 57 > ] bi or
    ]
    any?
    value length 2 <  or
    [
        f
    ]
    [
        value reverse
        [| elt i |
            elt 48 -  i score total + total!
        ]
        each-index

        total 10 divisor?
    ]
    if ;

: valid? ( value -- ? )
    [ 32 = ] reject valid-impl? ;