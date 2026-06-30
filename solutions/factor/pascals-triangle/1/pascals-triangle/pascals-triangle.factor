USING: arrays combinators kernel math sequences vectors ;
IN: pascals-triangle

: rows ( count -- triangle )
    { 1 } V{ } clone rot ! array vector count
    [
        2dup push ! array vector
        swap
        [ 0 prefix ] [ 0 suffix ] bi
        [ + ] 2map
        swap
    ]
    times
    nip >array ;