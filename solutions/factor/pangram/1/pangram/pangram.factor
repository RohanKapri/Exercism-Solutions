USING: kernel math math.bitwise sequences unicode ;
IN: pangram

: pangram-loop? ( sentence seen index -- ? )
    dup 0 =
    [
        drop swap drop
        0x3ffffff =
    ]
    [
        1 - pick ! sentence seen index sentence
        dupd nth ! sentence seen index ch
        dup LETTER?
        [
            CHAR: A - ! sentence seen index letter
            1 swap shift ! sentence seen index update
            swapd bitor swap
        ]
        [
            drop
        ]
        if pangram-loop?
    ]
    if ;

: pangram? ( sentence -- ? )
    >upper dup length 0 swap pangram-loop? ;