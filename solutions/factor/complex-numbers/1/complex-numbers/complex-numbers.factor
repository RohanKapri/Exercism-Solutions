USING: accessors arrays combinators kernel locals math math.functions sequences ;
IN: complex-numbers

TUPLE: cmplx real imaginary ;

: <cmplx> ( real imag -- cmplx )
    cmplx boa ;

: >cmplx ( pair -- cmplx )
    [ first ] [ second ] bi <cmplx> ;

: cmplx>pair ( cmplx -- pair )
    [ real>> ] [ imaginary>> ] bi 2array ;

: c+ ( a b -- c )
    [ [ real>> ] bi@ + ] [ [ imaginary>> ] bi@ + ] 2bi <cmplx> ;

: c- ( a b -- c )
    [ [ real>> ] bi@ - ] [ [ imaginary>> ] bi@ - ] 2bi <cmplx> ;

:: c* ( a b -- c )
    a real>> b real>> *  a imaginary>> b imaginary>> *  -
    a imaginary>> b real>> *  a real>> b imaginary>> *  +
    <cmplx> ;

:: c/ ( a b -- c )
    b [ real>> ] [ imaginary>> ] bi [ dup * ] bi@ + :> d

    a real>> b real>> *  a imaginary>> b imaginary>> *  + d /
    a imaginary>> b real>> *  a real>> b imaginary>> *  - d /
    <cmplx> ;

: c-abs ( a -- |a| )
    [ real>> ] [ imaginary>> ] bi [ dup * ] bi@ + sqrt ;

: c-conj ( a -- a* )
    [ real>> ] [ imaginary>> neg ] bi <cmplx> ;

:: c-exp ( z -- e^z )
    z real>> e^ :> r
    z imaginary>> [ cos r * ] [ sin r * ] bi <cmplx> ;