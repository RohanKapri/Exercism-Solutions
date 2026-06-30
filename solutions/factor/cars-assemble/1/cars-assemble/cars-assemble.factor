USING: combinators kernel locals math ;
IN: cars-assemble

CONSTANT: base-speed 221

:: production-status ( speed -- status )
    speed zero?
    [ "stopped" ]
    [ "running" ]
    if ;

:: success-rate ( speed -- rate )
    speed
    {
        { [ dup 0 =  ] [ drop 0.0  ] }
        { [ dup 4 <= ] [ drop 1.0  ] }
        { [ dup 8 <= ] [ drop 0.9  ] }
        { [ dup 9 =  ] [ drop 0.8  ] }
                       [ drop 0.77 ]
    } cond ;

:: production-rate-per-hour ( speed -- rate )
    speed success-rate
    speed *
    base-speed * ;

:: working-items-per-minute ( speed -- count )
    speed production-rate-per-hour 60 /i ;