USING: accessors kernel locals math math.order ;
IN: queen-attack

ERROR: row-not-on-board ;
ERROR: column-not-on-board ;

TUPLE: queen row column ;

:: <queen> ( row column -- q )
    row 0 7 between? [ row-not-on-board ] unless
    column 0 7 between? [ column-not-on-board ] unless
    row column queen boa ;

:: can-attack? ( queen1 queen2 -- ? )
    queen1 row>> queen2 row>> - :> di
    queen1 column>> queen2 column>> - :> dj
    di 0 =
    dj 0 =
    di dj + 0 =
    di dj - 0 =
    or or or ;