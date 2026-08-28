USING: arrays combinators disjoint-sets kernel locals math sequences ;
IN: connect

SYMBOLS: O X ;


:: occupant ( r c board -- s )
    r board length <
    [
        c 2 * r +
        r board nth
        nth
        {
            { CHAR: O [ O ] }
            { CHAR: X [ X ] }
            [ drop f ]
        }
        case
    ]
    [
        c 2 <
        [
            O
        ]
        [
            X
        ]
        if
    ]
    if ;


:: adjacent ( ra ca rb cb board collection -- )
    board last length 2 + board length - 2 / :> columns
    ra ca board occupant
    rb cb board occupant
    =
    [
        columns ra * ca +
        columns rb * cb +
        collection equate
    ]
    when ;


:: winner ( board -- str )
    board length :> rows
    board last length 2 + board length - 2 / :> columns

    <disjoint-set> :> collection
    rows columns * 4 + <iota> collection add-atoms

    columns <iota>
    [| j |
        0 j rows 0 board collection adjacent ! top edge
        rows 1 - j rows 1 board collection adjacent ! bottom edge
    ]
    each

    rows <iota>
    [| i |
        i 0 rows 2 board collection adjacent ! left edge
        i columns 1 - rows 3 board collection adjacent ! right edge
    ]
    each

    rows <iota>
    [| i |
        columns 1 - <iota>
        [| j |
            i j i j 1 + board collection adjacent ! horizontal -
        ]
        each
    ]
    each

    rows 1 - <iota>
    [| i |
        columns <iota>
        [| j |
            i j i 1 + j board collection adjacent ! diagonal \
        ]
        each
    ]
    each

    rows 1 - <iota>
    [| i |
        columns 1 - <iota>
        [| j |
            i j 1 + i 1 + j board collection adjacent ! diagonal /
        ]
        each
    ]
    each

    4 <iota>
    [| k |
        rows columns * k + collection representative
    ]
    map :> roots

    {
        { [ roots [ first ] [ second ] bi = ] [ "O" ] }
        { [ roots [ third ] [ fourth ] bi = ] [ "X" ] }
        [ "" ]
    }
    cond ;