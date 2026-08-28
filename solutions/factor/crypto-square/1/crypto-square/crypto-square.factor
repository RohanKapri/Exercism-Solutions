USING: arrays  kernel locals math math.functions sequences strings unicode ;
IN: crypto-square
:: transpose ( plaintext -- cipher )
    plaintext length :> n
    n sqrt ceiling >integer :> columns
    n columns / ceiling >integer :> rows
    rows 1 + columns * 1 -  32 <array> :> result
    rows <iota>
    [| i |
        columns <iota>
        [| j |
            i columns * j +
            dup n <
            [
                 plaintext nth
                 rows 1 + j * i +  result set-nth
            ]
            [
                drop
            ]
            if
        ]
        each
    ]
    each
    result >string ;
: ciphertext ( plaintext -- cipher )
    [ [ digit? ] [ Letter? ] bi or ] filter >lower
    dup length 1 >
    [
         transpose
    ]
    when ;