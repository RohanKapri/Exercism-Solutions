USING: kernel locals math sequences strings ;
IN: hamming

:: measure ( strand1 strand2 acc -- n )
    strand1 length 0 =
    [ acc ]
    [
        strand1 1 tail
        strand2 1 tail
        strand1 first strand2 first = [ acc ] [ acc 1 + ] if
        measure
    ]
    if ;

:: distance ( strand1 strand2 -- n )
    strand1 length strand2 length = [ "strands must be of equal length" throw ] unless
    strand1 strand2 0 measure ;