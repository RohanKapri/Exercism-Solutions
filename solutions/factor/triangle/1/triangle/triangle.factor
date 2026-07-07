USING: accessors combinators kernel locals math ;
IN: triangle

TUPLE: triangle a b c ;

: <triangle> ( a b c -- triangle )
    triangle boa ;

:: valid? ( a b c -- ? )
    a 0 >
    b 0 > and
    c 0 > and
    a b + c >= and
    b c + a >= and
    c a + b >= and ;

:: equilateral? ( triangle -- ? )
    triangle a>> :> a!
    triangle b>> :> b!
    triangle c>> :> c!
    a b c valid?
    a b = and
    b c = and
    c a = and ;

:: scalene? ( triangle -- ? )
    triangle a>> :> a!
    triangle b>> :> b!
    triangle c>> :> c!
    a b c valid?
    a b = not and
    b c = not and
    c a = not and ;

:: isosceles? ( triangle -- ? )
    triangle a>> :> a!
    triangle b>> :> b!
    triangle c>> :> c!
    a b c valid?
    triangle scalene?
    not and ;