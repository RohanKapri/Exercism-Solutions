USING: accessors formatting hash-sets kernel math namespaces random sequences sets strings unicode ;
IN: robot-name

TUPLE: robot name ;

SYMBOL: reserved

: random-letter ( -- ch )
    26 random CHAR: A + ;

: random-digit ( -- ch )
    10 random CHAR: 0 + ;

HS{ } clone reserved set-global

:: allocate-name ( -- str )
    "" :> candidate!

    [ "" candidate = ]
    [
        random-letter
        random-letter
        random-digit
        random-digit
        random-digit
        "%c%c%c%c%c" sprintf candidate!

        candidate reserved get-global in?
        [
            "" candidate!
        ]
        when
    ]
    while

    candidate reserved get-global adjoin

    candidate ;

: <robot> ( -- robot )
    allocate-name robot boa ;

:: reset-name ( robot -- )
    robot allocate-name >>name drop ;