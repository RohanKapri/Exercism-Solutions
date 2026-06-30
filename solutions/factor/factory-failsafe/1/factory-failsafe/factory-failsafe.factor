USING: continuations kernel math sequences ;
IN: factory-failsafe

: check-humidity ( h -- )
    70 > [ "humidity too high" throw ] when ;

: check-temperature ( t -- )
    500 > [ "temperature too high" throw ] when ;

ERROR: machine-error ;

: monitor ( h t -- )
    '[ _ check-humidity _ check-temperature ]
    [ drop machine-error ]
    recover ;

: monitor-batch ( readings -- count )
    [
        [ first2 monitor 0 ]
        [ 2drop 1 ]
        recover
    ]
    map-sum ;