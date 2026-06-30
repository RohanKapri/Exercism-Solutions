USING: combinators kernel locals math unicode ;
IN: character-study
SYMBOLS: less equal greater
    big small no-size
    alpha numeric space newline unknown ;
:: compare-chars ( c1 c2 -- symbol )
    {
        { [ c1 c2 > ] [ greater ] }
        { [ c1 c2 < ] [ less    ] }
                      [ equal   ]
    } cond ;
:: compare-insensitive-chars ( c1 c2 -- symbol )
    {
        { [ c1 ch>lower c2 ch>lower > ] [ greater ] }
        { [ c1 ch>lower c2 ch>lower < ] [ less    ] }
                                        [ equal   ]
    } cond ;
:: size-of-char ( c -- symbol )
    {
        { [ c LETTER? ] [ big   ] }
        { [ c letter? ] [ small ] }
                        [ no-size ]
    } cond ;
:: change-size-of-char ( c desired -- c' )
    {
        { [ desired big   = ] [ c ch>upper ] }
        { [ desired small = ] [ c ch>lower ] }                   [ c ]
    } cond ;
:: type-of-char ( c -- symbol )
    {
        { [ c Letter?    ] [ alpha   ] }
        { [ c digit?     ] [ numeric ] }
        { [ c CHAR: \n = ] [ newline ] }
        { [ c blank?     ] [ space   ] }
                           [ unknown ]
    } cond ;