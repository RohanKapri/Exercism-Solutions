USING: arrays kernel locals math sequences strings ;
IN: series

:: slices ( series len -- slices )
    series empty? [ "series cannot be empty" throw ] when
    len 0 < [ "slice length cannot be negative" throw ] when
    len 0 = [ "slice length cannot be zero" throw ] when
    len  series length  > [ "slice length cannot be greater than series length" throw ] when


    series length 1 + len - :> n
    n <iota>
    [| i |
        series
        i tail-slice
        len head-slice
        >string
    ]
    map ;