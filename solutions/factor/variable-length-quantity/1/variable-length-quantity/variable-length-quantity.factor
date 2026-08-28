USING: arrays kernel locals math sequences ;
IN: variable-length-quantity


:: encode-integer ( integer -- bytes )
    V{ } clone :> result
    integer 127 bitand result push
    integer :> n!

    [ n -7 shift dup n! 0 > ]
    [
        n 127 bitand 128 bitor result push
    ]
    while

    result reverse ;


: encode ( integers -- bytes )
    [ encode-integer ] map concat >array ;


:: decode ( bytes -- integers )
    V{ } clone :> result
    0 :> n!

    bytes
    [| byte |
        n 7 shift  byte 127 bitand  bitor n!
        byte 128 bitand 0 =
        [
            n result push
            0 n!
        ]
        when
    ]
    each

    bytes ?last 0 or 128 bitand 0 =
    [
        "incomplete sequence" throw
    ]
    unless

    result >array ;