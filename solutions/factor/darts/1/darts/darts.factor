USING: kernel locals math ;
IN: darts

:: score ( x y -- n )
    x x *
    y y *
    +
    dup
    25 >
    [ 100 > [ 0 ] [ 1 ] if ]
    [ 1 > [ 5 ] [ 10 ] if ]
    if ;