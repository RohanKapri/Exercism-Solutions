USING: kernel math sequences ;
IN: flatten-array

:: flatten ( array -- flat )
    array number?
    [
        { array }
    ]
    [
        array [ f = ] reject [ flatten ] map concat
    ]
    if ;