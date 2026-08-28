USING: accessors combinators kernel locals math sequences ;
IN: robot-simulator

SYMBOLS: north east south west ;

TUPLE: robot x y direction ;

: <robot> ( x y direction -- robot )
    robot boa ;

:: turn-right ( robot -- robot )
    robot direction>>
    {
        { north [ robot east  >>direction ] }
        { east  [ robot south >>direction ] }
        { south [ robot west  >>direction ] }
        { west  [ robot north >>direction ] }
        [ drop robot ]
    }
    case ;

:: turn-left ( robot -- robot )
    robot direction>>
    {
        { north [ robot west  >>direction ] }
        { east  [ robot north >>direction ] }
        { south [ robot east  >>direction ] }
        { west  [ robot south >>direction ] }
        [ drop robot ]
    }
    case ;

:: advance ( robot -- robot )
    robot direction>>
    {
        { north [ robot [ 1 + ] change-y ] }
        { east  [ robot [ 1 + ] change-x ] }
        { south [ robot [ 1 - ] change-y ] }
        { west  [ robot [ 1 - ] change-x ] }
        [ drop robot ]
    }
    case ;

:: move-once ( robot instruction -- robot )
    instruction
    {
        { CHAR: R [ robot turn-right ] }
        { CHAR: L [ robot turn-left  ] }
        { CHAR: A [ robot advance    ] }
        [ drop robot ]
    } case ;

: move ( robot instructions -- robot )
    swap [ move-once ] reduce ;