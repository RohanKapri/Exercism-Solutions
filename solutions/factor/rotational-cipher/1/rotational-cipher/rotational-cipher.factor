USING: kernel math math.bitwise sequences unicode ;
IN: rotational-cipher

: rotate-char ( key text-char -- cipher-char )
    dup Letter?
    [
        dup 32 bitand -rot 32 bitor 97 - ! case-flag key index
        + 26 mod ! case-flag index
        65 + bitor
    ]
    [
        nip
    ]
    if ;

: rotate ( text key -- cipher )
    '[ _ swap rotate-char ] map ;