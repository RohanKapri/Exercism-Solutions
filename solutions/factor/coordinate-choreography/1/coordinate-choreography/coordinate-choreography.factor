USING: arrays kernel math math.vectors sequences ;
IN: coordinate-choreography

: translate-2d ( dx dy -- quot )
    '[ { _ _ } v+ ] ;

: scale-2d ( sx sy -- quot )
    '[ { _ _ } v* ] ;

: compose-transformations ( f g -- h )
    compose ;

: apply-transformation ( point f -- point' )
    call( p -- p' ) ; inline

: affine-2d ( a b c d -- quot )
    '[
        dup first _ * over second _ * +
        swap
        dup first _ * swap second _ * +
        2array
    ] ;

: transform-points ( points f -- points' )
    '[ _ call ] map ; inline