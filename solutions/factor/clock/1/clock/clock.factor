USING: combinators kernel math math.parser sequences splitting strings ;
IN: clock

: number>digits ( n -- str )
    [
        10 <
        [ "0" ]
        [ "" ]
        if
    ]
    [
        number>string
    ]
    bi append ;

: <clock> ( hour minute -- str )
    swap 60 * + 1440 mod 1440 + 1440 mod
    60 /mod [ number>digits ] bi@
    ":" prepend append ;

: add-minutes ( clock minutes -- clock' )
    swap ":" split1
    [ string>number ] bi@
    rot + <clock> ;

: subtract-minutes ( clock minutes -- clock' )
    neg add-minutes ;

: clock= ( clock1 clock2 -- ? )
    [ 0 add-minutes ] bi@
    = ;