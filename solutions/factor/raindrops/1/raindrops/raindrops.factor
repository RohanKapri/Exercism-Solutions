USING: kernel locals math math.functions math.parser sequences ;
IN: raindrops

:: sound ( n factor name -- str )
    n factor divisor?
    [ name ]
    [ "" ]
    if ;

:: convert ( n -- str )
    n 3 "Pling" sound
    n 5 "Plang" sound append
    n 7 "Plong" sound append
    dup "" =
    [ drop n number>string ]
    [ ]
    if ;