USING: kernel math sequences locals ;
IN: binary-chop

ERROR: value-not-in-array ;

:: search ( array value low high -- index )
    low high > [
        value-not-in-array
    ] [
        low high + 2 /i :> mid
        mid array nth :> item

        value item = [
            mid
        ] [
            value item < [
                array value low mid 1 - search
            ] [
                array value mid 1 + high search
            ] if
        ] if
    ] if ;

:: find ( array value -- index )
    array value 0 array length 1 - search ;