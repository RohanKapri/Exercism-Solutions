USING: kernel locals math math.parser sequences splitting ;
IN: matrix

:: nth-row ( str n -- row )
    str "\n" split n 1 - swap nth " " split
    [
        string>number
    ]
    map ;

:: nth-column ( str n -- column )
    str "\n" split
    [
        " " split n 1 - swap nth string>number
    ]
    map ;