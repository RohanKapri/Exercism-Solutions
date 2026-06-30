USING: arrays combinators kernel locals math math.order sequences splitting ;
IN: sublist

SYMBOLS: equal sublist superlist unequal ;

:: sublist? ( list-one list-two -- ? )
    list-one length list-two length - 0 max 1 + <iota>
    [| index |
        list-one index tail-slice
        list-two ?head-slice nip
    ]
    any? ;

:: relation ( list-one list-two -- result )
    list-one list-two sublist?
    list-two list-one sublist?
    2array
    {
        { { t t } [ equal ] }
        { { t f } [ superlist ] }
        { { f t } [ sublist ] }
        { { f f } [ unequal ] }
        [ ]
    }
    case ;