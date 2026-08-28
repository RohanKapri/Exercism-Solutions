USING: accessors arrays combinators kernel locals math math.functions sequences ;
IN: rational-numbers

TUPLE: rat numerator denominator ;

:: <rat> ( numerator denominator -- rat )
    numerator denominator gcd nip :> common!
    denominator common * 0 < [ common neg common! ] when
    numerator common /i  denominator common /i rat boa ;

: >rat ( pair -- rat )
    [ first ] [ second ] bi <rat> ;

: rat>pair ( rat -- pair )
    [ numerator>> ] [ denominator>> ] bi 2array ;

:: r+ ( a b -- c )
    a numerator>> :> an
    a denominator>> :> ad
    b numerator>> :> bn
    b denominator>> :> bd
    an bd *  ad bn *  +
    ad bd *
    <rat> ;

:: r- ( a b -- c )
    a numerator>> :> an
    a denominator>> :> ad
    b numerator>> :> bn
    b denominator>> :> bd
    an bd *  ad bn *  -
    ad bd *
    <rat> ;

:: r* ( a b -- c )
    a numerator>> :> an
    a denominator>> :> ad
    b numerator>> :> bn
    b denominator>> :> bd
    an bn *
    ad bd *
    <rat> ;

:: r/ ( a b -- c )
    a numerator>> :> an
    a denominator>> :> ad
    b numerator>> :> bn
    b denominator>> :> bd
    an bd *
    ad bn *
    <rat> ;

: r-abs ( a -- |a| )
    [ numerator>> abs ] [ denominator>> ] bi <rat> ;

! `r^` raises a `rat` to an integer power.
:: r^ ( a n -- a^n )
    n 0 >=
    [
        a numerator>>  n ^
        a denominator>>  n ^
    ]
    [
        a denominator>>  n neg  ^
        a numerator>>  n neg  ^
    ]
    if
    <rat> ;

! `real^r` raises a real to a `rat` exponent and returns a float.
:: real^r ( x a -- y )
    x  a numerator>> a denominator>> /  ^ ;