USING: combinators kernel locals math sequences ;
IN: binary-search

ERROR: value-not-in-array ;

:: search ( low high array value -- index )
    high low <= [ value-not-in-array throw ] when
    low high + 2 /i ! index
    dup array nth ! index element
    {
        { [ dup value < ] [ drop  1 +  high array value search ] }
        { [ dup value > ] [ drop low swap array value search ] }
        [ drop ]
    }
    cond ;

:: find ( array value -- index )
    0  array length  array value search ;