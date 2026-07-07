USING: combinators kernel locals math sequences ;
IN: kindergarten-garden

: decode ( letter -- plant )
    {
        { CHAR: C [ "clover" ] }
        { CHAR: G [ "grass" ] }
        { CHAR: R [ "radishes" ] }
        { CHAR: V [ "violets" ] }
        [ "unknown plant" throw ]
    }
    case ;

:: plants ( diagram student -- plants )
    0 student nth CHAR: A - 2 * :> a
    a 1 + :> b
    diagram length 1 + 2 /i a + :> c
    c 1 + :> d
    { a b c d } [ diagram nth decode ] map ;