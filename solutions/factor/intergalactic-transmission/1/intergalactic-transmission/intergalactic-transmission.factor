USING: arrays kernel locals math math.bitwise sequences ;
IN: intergalactic-transmission


:: transmit-sequence ( message -- sequence )
    V{ } clone :> result
    0 :> count!
    0 :> pending!

    message
    [| elt index |
        pending 8 shift elt bitor pending!
        count 1 + count!
        pending count neg shift result push

        index 1 +  message length  =
        [
            pending  7 count - shift pending!
            7 count!
        ]
        when

        count 7 =
        [
            pending result push
            0 count!
        ]
        when
    ]
    each-index

    result
    [| elt |
        elt 0x7f bitand
        1 shift
        dup odd-parity?
        [
            1 bitor
        ]
        when
    ]
    map
    >array ;


:: decode-message ( sequence -- message )
    V{ } clone :> result
    0 :> count!
    0 :> pending!

    sequence
    [| elt |
        elt odd-parity?
        [
            "wrong parity" throw
        ]
        when

        elt -1 shift  pending 7 shift  bitor pending!
        count 7 + count!
        count 8 >=
        [
            count 8 - count!
            pending count neg shift 0xff bitand result push
        ]
        when
    ]
    each

    result >array ;