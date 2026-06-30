USING: kernel math math.bitwise sequences unicode ;
IN: isogram

: isogram-loop? ( phrase seen index -- ? )
    dup 0 =
    [
        3drop
        t
    ]
    [
        1 - pick ! phrase seen index phrase
        dupd nth ! phrase seen index ch
        dup LETTER?
        [
            CHAR: A - ! phrase seen index letter
            1 swap shift ! phrase seen index update
            swapd ! phrase index seen update
            2dup bitand 0 =
            [
                bitor swap ! phrase seen index
                isogram-loop?
            ]
            [
                4drop
                f
            ]
            if
        ]
        [
            drop isogram-loop?
        ]
        if
    ]
    if ;

: isogram? ( phrase -- ? )
    >upper dup length 0 swap isogram-loop? ;