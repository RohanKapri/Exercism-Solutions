USING: combinators formatting kernel locals make math math.functions math.parser sequences strings ;
IN: line-up

:: suffix ( number -- str )
    {
        { [ number 10 /i 10 mod 1 = ] [ "th" ] }
        { [ number 10       mod 1 = ] [ "st" ] }
        { [ number 10       mod 2 = ] [ "nd" ] }
        { [ number 10       mod 3 = ] [ "rd" ] }
                                      [ "th" ]
    } cond ;

:: format ( name number -- str )
    name
    number number>string
    number suffix
    "%s, you are the %s%s customer we serve today. Thank you!" sprintf ;